import React from 'react'
import { StyleSheet, View, Text } from 'react-native'
import Constants from 'expo-constants'


export default function App() {

    return (
        <View style={styles.container}>
            
            <Text>.</Text>
            <StatusBar style="auto" />
            
        </View>
    )
}

const styles = StyleSheet.create({

    container: {
        padding: 50,
        flex: 1,
    }
    
})