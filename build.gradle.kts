plugins {
    kotlin("multiplatform") version "1.7.0"
}

group = "com.electra"
version = "0.0.1"

repositories {
    mavenCentral()
}

kotlin {
    jvm {
        compilations.all {
            kotlinOptions.jvmTarget = "1.8"
        }
        withJava()
        testRuns["test"].executionTask.configure {
            useJUnitPlatform()
        }
    }
    val hostOs = System.getProperty("os.name")
    // We don't build for iOS in case we are not on Mac OS
    if (hostOs == "Mac OS X") {
        iosArm64("native") {
            binaries {
                framework {
                    baseName = "Mobile"
                }
            }
        }
    }
    
    sourceSets {
        val commonMain by getting
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val jvmMain by getting
        val jvmTest by getting
        val nativeMain by getting
        val nativeTest by getting
    }
}
