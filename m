Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489D62540D
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Nov 2022 07:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKKGsw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Nov 2022 01:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKGsv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Nov 2022 01:48:51 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2105.outbound.protection.outlook.com [40.107.113.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95568B841;
        Thu, 10 Nov 2022 22:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT7KPUV8JBmzcRSjrJsu+XaQeQiwdsQ7HBA4ucKJTetd3/X+7GdycuV/8WDlUT63Z7eFRG1A0NnVcJuV0o9Hu96UTKokDGfme1U8tTFqhHIsENlZjy0pLP/7BQ7qzCwjtNJlm5VhHqFgWri1V28sSmQqzahFg0nfYJ4TfOCVdCvCtQev2K/eIDiqFWXmLtml8yTuz9asODd2GKPFzTshMPAqkyfBi/bI8d5vCGDpamVRejeACnCTwRubi0tAV4DG+PHB3jgDSMijaSJ/O003U2cHE8WHB66qrZd5GxyuG3rhbWBAOObDCCt0g0jtn0Lgl5/eMUmvvgZWvR61/KvtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zwFEcskFB7MqxLM8xW1vMrw3CYm3msyNa1icw0Rd+4=;
 b=APZGpMeRehaVmu/Lk0BHHv+AIPdn6OGVP6STquueGCOZcp13h99DmvGXxVjw7ly3us4LxcEV7UFHtS7qeernEI9z5azUMVPKr/xByEUrKdD/YdBuXpMj9BkCQzEBIvj4Zjt3/vkVlBMiSiCFp5OXXWkYW8/KrYlE52UexNJPHO6LDMDh6c11QGPLcCeHOqBtfa/oZdkEbRdAmBev24/HeO7I82/p9a4jvxWMYTL1bH3GKCmum8N6I2HEAEJUpCG6djKkJaDNjx+tHCw9Ul4vcipT0XrZiFS81W6sERwRRU70Ms1soZ70WswUyOkMuN3XH9wJgaHX7Bj0fc8+jyRurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zwFEcskFB7MqxLM8xW1vMrw3CYm3msyNa1icw0Rd+4=;
 b=XQSND0VYMhdDHlw98jwNO86xr46R9QxoFMCffRbIDADfF0LzjtPQZgz2CGau0NxHXyaY1Gw7VdWqp3yzJkTmA2x4Z5ob7nJb720eIZ8fOtzt5S1fR4Nl/mWdiEq4opH5l+4x3Wspjo3sHcHeP12Iw1L8C7LV1JxQNfN8tcrlGJg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10763.jpnprd01.prod.outlook.com (2603:1096:400:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 06:48:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.014; Fri, 11 Nov 2022
 06:48:47 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v10 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v10 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHY8szyFfdaz8EsEkCQ+VPSMc5Sy640wA+AgAAAqWCABIx0kA==
Date:   Fri, 11 Nov 2022 06:48:47 +0000
Message-ID: <OS0PR01MB59222B5FBF41C3A82D6281CD86009@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221107171809.2797499-1-biju.das.jz@bp.renesas.com>
 <20221107171809.2797499-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVaY5j--jSc2WUZ=Mmyr83RFvNiTNXKzv3fUSPk9wsKqQ@mail.gmail.com>
 <OS0PR01MB592224E8BACCF03EC3FFE615863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592224E8BACCF03EC3FFE615863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10763:EE_
x-ms-office365-filtering-correlation-id: c165b626-e5e3-4d2a-12eb-08dac3b0c896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nW7t8A0rfcDIJmPdJMUmd3NOFioqQdPnn7NpC79NTJ3Z65X383WpxM8rjCpv71ANaP/nndxYYwa9OtBMrmqTPsrJ06+YRNTw/OWWQ3GY4nY+V6PzREaUnXYIb3qnl+N49TZg4U75JN3W0DnoGaqB9u78MrgGwLLflcuWzWY59hlsE554Y5+EW/tKyykvWdBClJS+ahwUMdaQTyMWRp2kz5LO7q1frWXgBpOP+8XDqba+2Q34mHlvgK4BIaqidRFZYHPyz26TuoLpJjl27+fy1tbGjNb3GdaeZRLV70jxDn9auk9Ur0L+WPnoWg1Lxn1wWS0P4DabjySVyvHLRYyJp6PhVUP1FvTBQ/4KVhwOHufeR0MjYDIfbkEy/Bm8dXnVU/IZPDOBdeTxHvPhuzOyGtpQQY2Fk50FdnBwWDSIkoFXhPP/Y30eBt5kKUq/1E/xvxHIuZOiekf8nJDXdYM6ZXgvatxOs07LEc+W9r7xVwQTyZggQ+mt5YK9GjyypKgv0jENxAXU8ZboqZqX3l8lMesbNHwrn5lTNGpx47jYmIESkb6hrTokdP4m9UFp+4DE8Ks7w1II5osyQG9JCjM2BRwFdwkUEfPE3Adq3DuuO4Nph2sbNk2RUVTUu56wk66SVjlQos36HKw5wKPNIAQbdN7/hN4MtKs0LxIJMujD+LhioEU4cWZ+rOmhNvCFxJKX4cfhBdkdbNhdjGCg93Wf6en5lFSn7H84WhMZu1YZqY1VuTeSWF7FYJzNRKC2ljJGJxShVJoa/Br5/MR9yFjo1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(55016003)(8936002)(54906003)(86362001)(66946007)(6916009)(52536014)(5660300002)(41300700001)(71200400001)(38070700005)(38100700002)(478600001)(76116006)(2906002)(33656002)(9686003)(53546011)(6506007)(64756008)(7696005)(4326008)(26005)(8676002)(66476007)(66556008)(316002)(66446008)(66574015)(83380400001)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ci80Q1doM1JQMXc3MTVaM3RCUkRKTlp0bi90V21HU0RFMG5pMUdRREdUc3VU?=
 =?utf-8?B?SzJRS2RjNXVsN0Q1dCtpaWtDcEdMTFgrRmJ4eUtqOUpZV0ZpZG1wb0Z2Z0hh?=
 =?utf-8?B?VE0xY3pKcmRDQ0FvV3lVMWdETTJUaVM0VVRtdXZZS080Q3ZqNnA3Znc4SEto?=
 =?utf-8?B?V2pRT2t3RW9Ec0pqbXNsNWY1R2QycU5iTzQwUFhjMXZmSXI3SHd2QjhPRU9o?=
 =?utf-8?B?MndjcjZZSWtHTGRTdk1zMkw5eUlxRHZXSUVnWCs1RXlVZG9EUk42dDdHTGNv?=
 =?utf-8?B?Mm5nT0duWGhIeGVEVzViREp2RWduZng0aHFteGxwNXRmbkNNQTA2SU1EOXQ4?=
 =?utf-8?B?ZVFBRFJuclpkNFhOZUJMTDB0ZmRySEx0ekdCampJOWxTZnlVQzVaTkRHT1pO?=
 =?utf-8?B?VmgrbDNaSEFRRkZZK1YrWVJ2UGQyS1JjK1BGcE1GVytJenRoOEJQQ3cycFhh?=
 =?utf-8?B?ZXZoWkJuS08wL2ppc1AyU3dPTyt2ZnVlY090QmRCRlFyR2twTkVBek5iVENs?=
 =?utf-8?B?djJGbE82YzNkeGJ4ZGFZYzRKT3ZkNnpnS2E3bmI0dmhCNmx1aUNVWXJEOVJv?=
 =?utf-8?B?a1UwTStzck1WMjNZYXByZmdtMDh2TVdQY3B3ZXZDMHJWODlLVmdZUDBzN0ZK?=
 =?utf-8?B?elBBYlJ0b2R0RDVtSXpVZzZZMVhGNGxVUmFqcUpnTEp1eG1nY2ZGcWRwbEdN?=
 =?utf-8?B?MjJYR3pOK0VkMVBBM2U2cHFjWjZIc2VDY0lraThpaXVTMW5YQ29rWTlPelZu?=
 =?utf-8?B?VU4rVWxyNEZoNWpuNFluMEgrSE56THJkUVFobU56SWVTVDZqWUlvSjNkalBo?=
 =?utf-8?B?cWNzY01RWjMrSXJ5eWxxL0w1NmJWMXlwdGR4TXBUYWZ1NDlzZTF4ekZYNjc5?=
 =?utf-8?B?bXdqV2JmbHl2NFA3dTZyV0N0OWFjOUJ3d0J5WDBrdDNKMGpCSkdtUVRiSUhw?=
 =?utf-8?B?dm1rSW14Z0lJMTdoenE5VzdqUm1uam1kSjVIbmR0UitKK01IU1lZdlRGQWNF?=
 =?utf-8?B?S3NzNFZDWERXYWp6M2xheVBOMFNhdHBLWSs1aGFVTjdiOVlQYXZsZ00yYU5T?=
 =?utf-8?B?ZzFRWThuRklLcnY5SVZEYlAvcGVpTkN0UnRYUVAyY0J6MHlJM3NzYWhxa0Ji?=
 =?utf-8?B?YUd6dmRwaDFGcnVsM2JaeTdsMlQ4dkdINDVhL1VzNEljcHpkcjQ2QVA0K2l2?=
 =?utf-8?B?Q3F2S3duMm5yMWNHYkwzTzk3SzNBWkVZMnp3UDMwV2lCNkNMZTYzZE92Tzhx?=
 =?utf-8?B?ZUU1T3gzOU5CVVRIbXU2aTJvWnRQZVRYVVlsR2szNXhERytTNDZ4MHVBUXRF?=
 =?utf-8?B?SmNPQTg4dG1TS3gxL2VOMUNMMzRFZElPWEIzZnltMEhxSVZIS01xVi93QlR2?=
 =?utf-8?B?N2FjbFllZDNLeUxLRUpFTFZPcDl3b2dyNE4veWxPbGgyYUlXU2dLZWlmd1l0?=
 =?utf-8?B?cG9tRU1FTnR2WHlqQnFVdlB0ZmR6VkR4dmEvREhmd1phZmREMTNER2VPSkls?=
 =?utf-8?B?WkVBRU11VnFQNGo5dUM3cHpodUcwWjdDVU9qc2pibU5ZbDVBZGNJZzV1OEdL?=
 =?utf-8?B?Vk1jOFVIeEZQdVhpMGdzU25Eek5HVVQ3UERjREpmc1dOSjdOWDdSTVkyZU9u?=
 =?utf-8?B?RmR2Umg2MXZhSkUwREEwbVBYZThZZkNGQTdzd1BodEpqYk1waytyNlJSRjFO?=
 =?utf-8?B?NDRXZ2txL3dsa203SjdHNER1T1pjUndHNDVZY0c0Sjl0OTdqTHBLdWIzUFND?=
 =?utf-8?B?OTdWUW13YmVEbFRXWExVL1U3Z0hYaGgzdS9ZUEVSR3ExZ2xHSWhsN3lGOVFy?=
 =?utf-8?B?M3dMN0g2RzQyVnFqWXJXSUJqUFJWQnJmSVdqQTduQ1lteEdHZFBzblQ0ZzZ1?=
 =?utf-8?B?ckdyaDArQ3VXUUdOUTlRaUpCem5TdTA2U2d3a3VnTmZrREtGVUVNZDV2bVRP?=
 =?utf-8?B?bDdXVlkvZ3hxeXNBNHQ2UjdmQW43Z0ZtVm5ZMW9tbndKcUxTU3FoVTRBcW1R?=
 =?utf-8?B?TXBCdWZrSlJmbmduQm95Ty9LYnVpVnpVa1JqcGNLUnFlMzFXRmRkNFJuVkdM?=
 =?utf-8?B?c1dXazBoLzdMQW9EK3VLcldTVDNJejBSNnFmcVZ4RVBxSDhCekJ2cXZXWFpl?=
 =?utf-8?B?UVZEZ1hOMm1tTnVPb0cvR2ViOEdoL0FBcnJ4Z1BUQ2h5U0lESjB2bmF3Myt5?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c165b626-e5e3-4d2a-12eb-08dac3b0c896
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:48:47.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrC5r73ktVB0zYmcYCye+vDSvqC53BSesZZPLWz5i0sElxC3iiuxh7JAGWBjDwLkYrzNlaIU6s29E7PIF9lS2jvjx+D5HuqbClKMcH4SOv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10763
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIHYxMCAyLzJdIHB3bTogQWRkIHN1cHBvcnQgZm9yIFJaL0cy
TCBHUFQNCj4gDQo+IEhpIEdlZXJ0LA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+
ID4gU2VudDogMDggTm92ZW1iZXIgMjAyMiAwOToxNw0KPiA+IFRvOiBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gQ2M6IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJl
ZGluZ0BnbWFpbC5jb20+OyBQaGlsaXBwIFphYmVsDQo+ID4gPHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU+OyBVd2UgS2xlaW5lLUvDtm5pZw0KPiA+IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+OyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBHZWVydA0KPiA+IFV5dHRlcmhvZXZlbiA8
Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBDaHJpcyBQYXRlcnNvbg0KPiA+IDxDaHJpcy5QYXRl
cnNvbjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+Ow0K
PiA+IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtIGxhZC5yakBicC5y
ZW5lc2FzLmNvbT47DQo+ID4gbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMi8yXSBwd206IEFkZCBzdXBwb3J0IGZvciBSWi9HMkwg
R1BUDQo+ID4NCj4gPiBIaSBCaWp1LA0KPiA+DQo+ID4gT24gTW9uLCBOb3YgNywgMjAyMiBhdCA2
OjE4IFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4g
PiBSWi9HMkwgR2VuZXJhbCBQV00gVGltZXIgKEdQVCkgY29tcG9zZWQgb2YgOCBjaGFubmVscyB3
aXRoIDMyLWJpdA0KPiA+ID4gdGltZXIgKEdQVDMyRSkuIEl0IHN1cHBvcnRzIHRoZSBmb2xsb3dp
bmcgZnVuY3Rpb25zDQo+ID4gPiAgKiAzMiBiaXRzIMOXIDggY2hhbm5lbHMNCj4gPiA+ICAqIFVw
LWNvdW50aW5nIG9yIGRvd24tY291bnRpbmcgKHNhdyB3YXZlcykgb3IgdXAvZG93bi1jb3VudGlu
Zw0KPiA+ID4gICAgKHRyaWFuZ2xlIHdhdmVzKSBmb3IgZWFjaCBjb3VudGVyLg0KPiA+ID4gICog
Q2xvY2sgc291cmNlcyBpbmRlcGVuZGVudGx5IHNlbGVjdGFibGUgZm9yIGVhY2ggY2hhbm5lbA0K
PiA+ID4gICogVHdvIEkvTyBwaW5zIHBlciBjaGFubmVsDQo+ID4gPiAgKiBUd28gb3V0cHV0IGNv
bXBhcmUvaW5wdXQgY2FwdHVyZSByZWdpc3RlcnMgcGVyIGNoYW5uZWwNCj4gPiA+ICAqIEZvciB0
aGUgdHdvIG91dHB1dCBjb21wYXJlL2lucHV0IGNhcHR1cmUgcmVnaXN0ZXJzIG9mIGVhY2ggY2hh
bm5lbCwNCj4gPiA+ICAgIGZvdXIgcmVnaXN0ZXJzIGFyZSBwcm92aWRlZCBhcyBidWZmZXIgcmVn
aXN0ZXJzIGFuZCBhcmUgY2FwYWJsZSBvZg0KPiA+ID4gICAgb3BlcmF0aW5nIGFzIGNvbXBhcmlz
b24gcmVnaXN0ZXJzIHdoZW4gYnVmZmVyaW5nIGlzIG5vdCBpbiB1c2UuDQo+ID4gPiAgKiBJbiBv
dXRwdXQgY29tcGFyZSBvcGVyYXRpb24sIGJ1ZmZlciBzd2l0Y2hpbmcgY2FuIGJlIGF0IGNyZXN0
cyBvcg0KPiA+ID4gICAgdHJvdWdocywgZW5hYmxpbmcgdGhlIGdlbmVyYXRpb24gb2YgbGF0ZXJh
bGx5IGFzeW1tZXRyaWMgUFdNDQo+IHdhdmVmb3Jtcy4NCj4gPiA+ICAqIFJlZ2lzdGVycyBmb3Ig
c2V0dGluZyB1cCBmcmFtZSBjeWNsZXMgaW4gZWFjaCBjaGFubmVsICh3aXRoIGNhcGFiaWxpdHkN
Cj4gPiA+ICAgIGZvciBnZW5lcmF0aW5nIGludGVycnVwdHMgYXQgb3ZlcmZsb3cgb3IgdW5kZXJm
bG93KQ0KPiA+ID4gICogR2VuZXJhdGlvbiBvZiBkZWFkIHRpbWVzIGluIFBXTSBvcGVyYXRpb24N
Cj4gPiA+ICAqIFN5bmNocm9ub3VzIHN0YXJ0aW5nLCBzdG9wcGluZyBhbmQgY2xlYXJpbmcgY291
bnRlcnMgZm9yIGFyYml0cmFyeQ0KPiA+ID4gICAgY2hhbm5lbHMNCj4gPiA+ICAqIFN0YXJ0aW5n
LCBzdG9wcGluZywgY2xlYXJpbmcgYW5kIHVwL2Rvd24gY291bnRlcnMgaW4gcmVzcG9uc2UgdG8g
aW5wdXQNCj4gPiA+ICAgIGxldmVsIGNvbXBhcmlzb24NCj4gPiA+ICAqIFN0YXJ0aW5nLCBjbGVh
cmluZywgc3RvcHBpbmcgYW5kIHVwL2Rvd24gY291bnRlcnMgaW4gcmVzcG9uc2UgdG8gYQ0KPiA+
ID4gICAgbWF4aW11bSBvZiBmb3VyIGV4dGVybmFsIHRyaWdnZXJzDQo+ID4gPiAgKiBPdXRwdXQg
cGluIGRpc2FibGUgZnVuY3Rpb24gYnkgZGVhZCB0aW1lIGVycm9yIGFuZCBkZXRlY3RlZA0KPiA+
ID4gICAgc2hvcnQtY2lyY3VpdHMgYmV0d2VlbiBvdXRwdXQgcGlucw0KPiA+ID4gICogQS9EIGNv
bnZlcnRlciBzdGFydCB0cmlnZ2VycyBjYW4gYmUgZ2VuZXJhdGVkIChHUFQzMkUwIHRvDQo+ID4g
PiBHUFQzMkUzKQ0KPiA+ID4gICogRW5hYmxlcyB0aGUgbm9pc2UgZmlsdGVyIGZvciBpbnB1dCBj
YXB0dXJlIGFuZCBleHRlcm5hbCB0cmlnZ2VyDQo+ID4gPiAgICBvcGVyYXRpb24NCj4gPiA+DQo+
ID4gPiBUaGlzIHBhdGNoIGFkZHMgYmFzaWMgcHdtIHN1cHBvcnQgZm9yIFJaL0cyTCBHUFQgZHJp
dmVyIGJ5IGNyZWF0aW5nDQo+ID4gPiBzZXBhcmF0ZSBsb2dpY2FsIGNoYW5uZWxzIGZvciBlYWNo
IElPcy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHY5LT52MTA6DQo+ID4gPiAgKiBVcGRh
dGVkIHRoZSBlcnJvciBoYW5kbGluZyBpbiBwcm9iZSgpLCBjbGtfZGlzYWJsZV91bnByZXBhcmUg
Y2FsbGVkDQo+ID4gPiAgICBvbiB0aGUgZXJyb3IgcGF0aC4NCj4gPiA+ICAqIFJlbW92ZWQgY2hf
ZW4gYXJyYXkgYW5kIHN0YXJ0ZWQgdXNpbmcgYml0bWFzayBpbnN0ZWFkLg0KPiA+DQo+ID4gVGhh
bmtzIGZvciB0aGUgdXBkYXRlIQ0KPiA+DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysg
Yi9kcml2ZXJzL3B3bS9wd20tcnpnMmwtZ3B0LmMNCj4gPg0KPiA+ID4gK3N0YXRpYyBpbnQgcnpn
MmxfZ3B0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiA+ICsgICAg
ICAgREVDTEFSRV9CSVRNQVAoY2hfZW5fYml0cywgUlpHMkxfTUFYX1BXTV9DSEFOTkVMUyk7DQo+
ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gPiArICAgICAgIC8qDQo+ID4gPiArICAgICAgICAqICBX
ZSBuZWVkIHRvIGtlZXAgdGhlIGNsb2NrIG9uLCBpbiBjYXNlIHRoZSBib290bG9hZGVyIGhhcw0K
PiA+IGVuYWJsZWQgdGhlDQo+ID4gPiArICAgICAgICAqICBQV00gYW5kIGlzIHJ1bm5pbmcgZHVy
aW5nIHByb2JlKCkuDQo+ID4gPiArICAgICAgICAqLw0KPiA+ID4gKyAgICAgICAqY2hfZW5fYml0
cyA9IDA7DQo+ID4NCj4gPiBiaXRtYXBfemVybygpLCB3aGljaCB3aWxsIGJlIG9wdGltaXplZCB0
byBhIHNpbmdsZSBhc3NpZ25tZW50Lg0KPiANCj4gT0ssIFdpbGwgZG8gaXQgaW4gdGhlIG5leHQg
dmVyc2lvbi4gV2hpbHN0IHdhaXQgZm9yIG90aGVyIHJldmlld2VycyB0byBnaXZlDQo+IHNvbWUg
ZmVlZGJhY2sgZm9yIHRoZSBjdXJyZW50IHBhdGNoIHNldC4NCj4gDQoNCldpbGwgc2VuZCBWMTEg
d2l0aCB0aGlzIGNoYW5nZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
