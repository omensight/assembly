import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.phemeftheria.assembly"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
    create("release") {
        val keystoreProperties = Properties()
        val keystorePropertiesFile = rootProject.file("keystore.properties")
        if (keystorePropertiesFile.exists()) {
            keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
        }

        keyAlias = keystoreProperties["ALIAS"] as String
        keyPassword = keystoreProperties["KEY_PASSWORD"] as String
        storeFile = file(keystoreProperties["STORE_FILE"] as String)
        storePassword = keystoreProperties["STORE_PASSWORD"] as String
    }
}
    

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.phemeftheria.assembly"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        named("release") {
            signingConfig = signingConfigs.getByName("release")
        }

        named("debug") {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
