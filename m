Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB8702557
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjEOGv2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240226AbjEOGvM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 02:51:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2128.outbound.protection.outlook.com [40.107.6.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917BA19A4;
        Sun, 14 May 2023 23:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0S5LMSZVe93qAhJKdwCkkKpXtbWJ6A6zDOBLTyo6BsdCaXFI0tMgXNKpROvDCw6gz1Ry4HzJUw2XIFGU/+vMIqMqv9DF91mYxT0uTLkKTMHMD6obiMTP4kXLAhLMZr6SDlauLBJAA9J8UVKMNE+ONg079MTK9PUnEdSXumlv6i7vdjqYACdCyk/sDUGmaoOAiqjzZnEjXi1ICBKfkoQ1qAxB05Fw5RCutEvZjEu0IzTmmVlUQM4660TXz+kHdhW1b7/KNheyBhtYbUxz6KAXFbyvq173hqVGYh2E0aieI3L71BJ0kUkLFVgrz18EIXm9eZuLTfS+8vGCoEjrIPyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zITJMoiR47Pa4/SckBEEBmAnQCpu4bf6HiVk+xgamYk=;
 b=HJXnMSd74Gr26n1WrCOEIMKoXBYDk9Ir+Hh9wkzU26AdZHe3MIsov5J6Z2wMiMhHbWggepeHmZR6TBZsZE48Ri3SsT3T2Javy+sM0RZqtfeDT/FofHbZodYZFJCwPX+DU5nBh+rGRnpEln25+1Y8Y6n+Wn4tfFtUgjjXhTaWLDAwPvG83UwJVedBZgcsacC64JGJY1HljCAGNhETDN9Peprb58Yu+HoAcBzxtnvU9VYSBHYycf7vwokAKfk3wQtsKzQWk6ixmvlZT6a187Ibl1fPYLxcFcbDNN+h7s9TuWupRWTTO/h3cdKqHoxNi1AaN+Y3MrVUTjkYeHPSxnR8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zITJMoiR47Pa4/SckBEEBmAnQCpu4bf6HiVk+xgamYk=;
 b=R9jLwgu+EgZiBDaqG9T2H+IHahVzTC+ddriaf2IUpd7HidyRxyHLadxrc4t9moadL/KTSu9on1qQ10ytszg8tSXmrc7yEfhWfpUfWhsZqS3X8Vce9UmzOrV3wPfMk9rfjlftj/rQhxwYbQb8azTXdyYSc+zXTBJJ2L5U4ksa0+t/Ib8nd23DuECzuLZOlxIMl5kglCQ9yEgkju65HgfZ1fd8Os6/V0fixmlIuLzKm4PPoKn59NMp5nbDw+c2iGnil6uMjHTTOA+yztR2DnYXmVV0X3DEuPw6Zsie20GMWuq48xlrh5p/mi0/6GP+aL7QBiyuiqxwpqwWeov28a4akQ==
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by GV2PR03MB9353.eurprd03.prod.outlook.com (2603:10a6:150:d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:50:43 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::dc5e:955b:bc0d:4fa5]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::dc5e:955b:bc0d:4fa5%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:50:42 +0000
From:   Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: AW: EXTERNAL - [PATCH] Input: pwm-beeper - Support volume setting via
 sysfs
Thread-Topic: EXTERNAL - [PATCH] Input: pwm-beeper - Support volume setting
 via sysfs
Thread-Index: AQHZhQN0/+hnfxOB5kGnB+6dYqolpq9a5Rbw
Date:   Mon, 15 May 2023 06:50:42 +0000
Message-ID: <AS8PR03MB76211DFFD1261B00E55FF50BFA789@AS8PR03MB7621.eurprd03.prod.outlook.com>
References: <20230512185551.183049-1-marex@denx.de>
In-Reply-To: <20230512185551.183049-1-marex@denx.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=true;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2023-05-15T06:50:37Z;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ActionId=44d56799-f856-47c1-b0aa-800ff44b4157;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7621:EE_|GV2PR03MB9353:EE_
x-ms-office365-filtering-correlation-id: 2bd5ff09-4794-42e7-2922-08db5510b3eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfwUdTNLhYE6R+RutPYe+duEuz2zmvU4L87st5/QfDbe7HvbDYl5FDNP31Zh/9tkIegbpIFvvyI+tyKuWwa6CxLMLTDyFWW4olw2PImTC1TelGHhA/c1WfzFUYkZJwxGTUN80+vOawdCA1FPMQCYBUmkWM9fUNPvHExHYxrOKkLeNtZtWS+RdhLRP9kOpiAD/e1P5baGkWm6IV7zb5O7c+vD32+nZrsTa+xUujgchbKqiCd9eO0e5KtSetP9iOQCDkdz81OSKJW9ohBNbV/YxGH3Yd8dmnkFmacboxh+eKJjwtZqFPHlLAWvplXyA0f3n3E57aauQvQLQ79a5jfwFFA5QQYzAkjHTiI6siAsC8U42qE3eZEJaJk3lpmRl5Pz6tYGw/GYRyjlUNjnbKVcDngsBpY0jRcZiKzFT6qW7TigLgGebv305f20650yXqpMOLC0mHiKGR9/1zdRaOftwF3GY79P9LiaVarVLAFJahzFPI0Ty8UmCPdgfAfLMJD2nMPNIhXb6hP26h9CvdEvCSRunhpTT5QNGTDkHBFpT53wc97YUKaRRbY+mbEafIn94iY2G1pAWmN7WkiBhcHblAMdA51ykZYk5BkAyAsoy9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(83380400001)(6506007)(26005)(2906002)(33656002)(186003)(9686003)(38070700005)(52536014)(7696005)(966005)(86362001)(5660300002)(8936002)(71200400001)(8676002)(478600001)(110136005)(54906003)(38100700002)(41300700001)(64756008)(66446008)(316002)(66476007)(55016003)(122000001)(66946007)(76116006)(66556008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDJTTHBCcERsWFFaRGhLbHZNbnRkNDN1N08welJhb250c3NPRlFUaGY2dHpV?=
 =?utf-8?B?WVdsbGJIYnpLL1BDUFR3cWUzS3pWUGswSTB6Qmw2TlhIckpmKzNQcGdzc1Ez?=
 =?utf-8?B?SzlERnorWURaNm11emtxR0tlWUwvempGZDBDbHN6OE1GeU8yUEZFOGFQbnJI?=
 =?utf-8?B?MGNoUHFHdFBnWjhYcDFiWTNZUlBGc2xabmpnL2orV29EVytHWjZiSnJMWWVk?=
 =?utf-8?B?Z2JDcmNPMXJ0c21SMEJ1cThaMERhL085UEZWWUNxUllUMHFnU3hGeHFvdXBJ?=
 =?utf-8?B?R1VnS21nU1hMYzVNemxnaEN1V0hPMmxOM2R3RmEvZE16cXdHak0wOTJIWTRo?=
 =?utf-8?B?MlJIbTQ1M0plTGtoRU9uS3N3ZWEvaklVVXZiUCtzM0FQTFNrR1pXYUxlT2Uv?=
 =?utf-8?B?UmpUV25Bb1I4K0RYcWtqa0VyS0RjUTRWRFcwcWVWcElFQkR3L0EwOForN1Nh?=
 =?utf-8?B?ZzJlOGt1eWI4SExySUM0Tld1UGlNSmNnUFhjYWpxYnBRN1dBRlN6YjZRS3FS?=
 =?utf-8?B?V3F3ZW1ya3c4L2R6b1BoaTU5SHpkcXZHNHp5QW9rZk43RnZObzFXMkR4V09N?=
 =?utf-8?B?Q2NCbTc2em5pRmZMV0lrNjJOaVJTbkpNb2loZlUvVm1KaEV6RmdkNjQ0RWdD?=
 =?utf-8?B?VHNuTHJGVExFYVZ4bGVmY3p6Z09BbHFHKzdqWjNMb2pFR2s2R3JsNzdUZHhB?=
 =?utf-8?B?Rk9jTHJUN0NYeGl4YVcyeE5DbzdwekZGZzJLNDhuTnluVW9WNHRKRWFNWEdp?=
 =?utf-8?B?Nk83M0w1dWl0Vm9yV3o2MU5nM0ZFRVd6RmVsblAvL3FaWXY5Y096cDdqYzRx?=
 =?utf-8?B?WElOTGxTTjRla3JDNURuWTdUOGJIQmtIeEtDaUNZQk5Ia0JJNzhRUTJlczJM?=
 =?utf-8?B?dmZWZUhDK01HZ0E5KzhkK01rM21BZmxIMTZjMnlwMG9XdUFsNmpSc1RiUFh0?=
 =?utf-8?B?d0Z6WU1TN3FUVWVlZWsxeVlvcWtHbW9yOXozbThEVFNrbHRHYzRNVHNnVjRG?=
 =?utf-8?B?aE1lcFJiSUw1UUE4WU5OTWJzZW56amkrVStUbG9JSnR0eS9EeGdGSXQ4WlBD?=
 =?utf-8?B?TWFjRUppc2xEVS9NcnhTMUZFM01IS1g3QnJVdVBNdnhSNE4rZUtkYnpnSkxP?=
 =?utf-8?B?RUhMR2hlRVh5NGNTSnNTbVBRL0xQSU5vUXUvazRRanEwVEhzM0l6ODFlTk5Q?=
 =?utf-8?B?cFErUmdFQUQ2QXR4UGN5dnI1dlFTbEtYUHgyMlBVcTVEMGZSREdrTThUd1Y1?=
 =?utf-8?B?WUJvZ2JaaXVxOXFoTWtUSHd6cmpKa0FQSktKSWxEK2FxSnRMaGxzZTJPaUFP?=
 =?utf-8?B?eHNvYWdpMElRZHRFN2lNOUhsLzJBZDRrWHJieWxmNE5qQ0p1M0F6Qk9zNkU5?=
 =?utf-8?B?akJTbFJuSmNWSEtMYXpiZVNhanZEOUo5aTBTL2JudDdTTXA0a3BIS2MzSTV0?=
 =?utf-8?B?WTljNDd3M1RLaUE1Vkc1RXhEYUY5QnVWK0pxL2k5eXlrWmFVY1pKSzZrdmhQ?=
 =?utf-8?B?aEJOMWxaUFV4WHlmQ1dyVHZ5ME4rb0owcFhBMWdoQ0tmdE5LOG5rMVhUZzdU?=
 =?utf-8?B?OWkxdm42WFBleUY5ajFRUGdaZVZXN3VXOVZ5Y3hSUldpY2Z3LytoWVprQUI0?=
 =?utf-8?B?ZlFONFVMOGpIWEl0WnRQUVNxYXoyVyt2SWFEZVpxdWcydlljUVc2TVh2aGdm?=
 =?utf-8?B?aE4yOVo5dC9rZW00RGhFOTV1RkZ0dG9EVER6Q1UzakxoTXBmSklLb2Zrbk0y?=
 =?utf-8?B?Yy82Nk9hUHZMdXpNT0FZOWtmakljTWwySDRHcjBtQStMSGo4azhGd1NzME1a?=
 =?utf-8?B?blR3aC9HOFpPeFV3aDYyRHJDVVN3cmVBSzhyT1NVMzdhZG1seUZMdW1rRGkx?=
 =?utf-8?B?OEl0NkRwbzI3KzlDQWM3d3BkUUdnUVRzaVI3TUlRSHlqZzVnMC9XcnV0bHB2?=
 =?utf-8?B?U1R3NmYzVVVpbk5SeWg2OHNNSGV0S203b2R2TmJkckh6ZHBTRklnbUF6Kyty?=
 =?utf-8?B?SEZSZ1YzdXN0Y2RMbFkxQXpWVnRPbklUZDM5OGlnM0RuZ3ZzTGR5bjlESThs?=
 =?utf-8?B?SEh0NkREa0tTbE5Ld21UTkN0ZmdzTmZLLzQ2bUZyUEo0OXZpMGZqMkd3VUhr?=
 =?utf-8?Q?dkgo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd5ff09-4794-42e7-2922-08db5510b3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 06:50:42.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xg6rX8AhWewa5xW9xBl64f7WODQ4av8bbpEcMd0dCRTi6dxaanXCGn9hE06NX4zy6JcNyho01pghtoay9I2v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTWFyZWssDQoNCj4gVGhlIFBXTSBiZWVwZXIgdm9sdW1lIGNhbiBiZSBjb250cm9sbGVkIGJ5
IGFkanVzdGluZyB0aGUgUFdNIGR1dHkgY3ljbGUsIGV4cG9zZSB2b2x1bWUgc2V0dGluZyB2aWEg
c3lzZnMsIHNvIHVzZXJzIGNhbiBtYWtlIHRoZSBiZWVwZXIgcXVpZXRlci4NCj4gVGhpcyBwYXRj
aCBhZGRzIHN5c2ZzIGF0dHJpYnV0ZSAndm9sdW1lJyBpbiByYW5nZSAwLi41MDAwMCwgaS5lLiBm
cm9tIDAgdG8gNTAlIGluIDEvMTAwMHRoIG9mIHBlcmNlbnQgc3RlcHMsIHRoaXMgcmVzb2x1dGlv
biBzaG91bGQgYmUgc3VmZmljaWVudC4NCj4NCj4gVGhlIHJlYXNvbiBmb3IgNTAwMDAgY2FwIG9u
IHZvbHVtZSBvciBQV00gZHV0eSBjeWNsZSBpcyBiZWNhdXNlIGR1dHkgY3ljbGUgYWJvdmUgNTAl
IGFnYWluIHJlZHVjZXMgdGhlIGxvdWRuZXNzLCB0aGUgUFdNIHdhdmUgZm9ybSBpcyBpbnZlcnRl
ZCA+IHdhdmUgZm9ybSBvZiB0aGUgb25lIGZvciBkdXR5IGN5Y2xlIGJlbG93IDUwJSBhbmQgdGhl
IGJlZXBlciBnZXRzIHF1aWV0ZXIgdGhlIGNsb3NlciB0aGUgc2V0dGluZyBpcyB0byAxMDAlIC4g
SGVuY2UsIDUwJSBjYXAgd2hlcmUgdGhlIHdhdmUgZm9ybSB5aWVsZHMgdGhlIGxvdWRlc3QgcmVz
dWx0Lg0KPg0KPiAgU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+
IC0tLQ0KPiBBbiBhbHRlcm5hdGl2ZSBvcHRpb24gd291bGQgYmUgdG8gZXh0ZW5kIHRoZSB1c2Vy
c3BhY2UgaW5wdXQgQUJJLCBlLmcuIGJ5IHVzaW5nIFNORF9UT05FIHRvcCAxNmJpdHMgdG8gZW5j
b2RlIHRoZSBkdXR5IGN5Y2xlIGluIDAuLjUwMDAwIHJhbmdlLCBhbmQgYm90dG9tIDE2Yml0IHRv
IGVuY29kZSB0aGUgZXhpc3RpbmcgZnJlcXVlbmN5IGluIEh6IC4gU2luY2UgZnJlcXVlbmN5IGlu
IEh6IGlzIGxpa2VseSB0byBiZSBiZWxvdyBzb21lIDI1IGtIeiBmb3IgYXVkaWJsZSBiZWxsLCB0
aGlzIGZpdHMgaW4gMTZiaXRzIGp1c3QgZmluZS4gVGhvdWdodHMgPw0KDQpJIHRlbmQgdG8gbm90
IGNoYW5nZSBleGlzdGluZyB1c2VyLXNwYWNlIGludGVyZmFjZXMuIEkgd291bGQgcHJlZmVyIHRv
IGhhdmUgYW4gYWRkaXRpb25hbCBldmVudCBvciB1c2luZyBzeXNmcy4NCg0KPi0tLQ0KPk5PVEU6
IFRoaXMgdXNlcyBhcHByb2FjaCBzaW1pbGFyIHRvIFsxXSwgZXhjZXB0IGl0IGlzIG11Y2ggc2lt
cGxlci4NCj4gICAgICBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LWlucHV0L2NvdmVyLzIwMjMwMjAxMTUyMTI4LjYxNDQzOS0xLW1hbnVlbC50cmF1dEBtdC5j
b20vDQoNClRoaXMgb25lIGlzIG1vcmUgY29tcGxleCwgYmVjYXVzZSB0aGUgbWFwcGluZyBiZXR3
ZWVuIGR1dHkgY3ljbGUgYW5kIHZvbHVtZSBpcyBub3QgbGluZWFyLiBQcm9iYWJseSBpdCBkZXBl
bmRzIGFsc28gb24gdGhlIHVzZWQgYmVlcGVyIGhhcmR3YXJlIHdoaWNoIHZhbHVlcyBhcmUgZG9p
bmcgYSBzaWduaWZpY2FudCBjaGFuZ2UgaW4gdm9sdW1lLiBUaGVyZWZvcmUgdGhlIHBhdGNoc2V0
IGludHJvZHVjZWQgYSBtYXBwaW5nIGJldHdlZW4gdm9sdW1lIGxldmVscyBhbmQgZHV0eSBjeWNs
ZSB0aW1lcyBpbiB0aGUgZGV2aWNlLXRyZWUgdG8gYWxsb3cgdXNlci1zcGFjZSBhcHBsaWNhdGlv
bnMgdG8gY29udHJvbCB0aGUgYmVlcGVyIHZvbHVtZSBoYXJkd2FyZSBpbmRlcGVuZGVudGx5Lg0K
DQpSZWdhcmRzDQpNYW51ZWwNCg==
