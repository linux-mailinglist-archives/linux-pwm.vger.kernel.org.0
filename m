Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A45FB1D9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJKLxu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJKLxt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 07:53:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC27F244;
        Tue, 11 Oct 2022 04:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbYiMn2S1OCfiBYbQnu3mLkhAJVYUWdc/LLhmI20ml6Pm4ltJ3RBOKh1g7IB9J8pbc/3zpqo/Gfv/DJwAE6oA5ZSyUVXAq2UKH2peOXGN/sdjAlInuBZRqGgZkOHJoc0dW9P256nMXVtrJ/XwFZy2XFuvYJG+30iFGYNe6QkOXgOyNiBjJP2tnwSF1zaLMgh74ETuL42c/KY4vHKQ+gpjDfawPLh5djteZLPF6qbWKgwDOx8ku1Vig9MBdlHWZ1tqNWmfgdPd3VKOY9ucRxShsbjc8ssYKrnIb0CM1MqazerAdR8VEVXEPxjpbcz4pKuHPmC9HnaRuM3sgrs8WAcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9EF64BUKtbC8TpGI0xQp+wTYoYLyWCJKpsilhYtu4I=;
 b=K5dF6dCMeU2e0zK9srxUZdJKtgrTQSfkxkvYRlyhot/WJ/pXgCntcRfb9+/l8nJf0Wr4wCDvo4e3MvxubC6v6eGWaIFVPVUZELJhfokvio7RygMoqCrC+JS71C59MLiGo8qgJzhnmFFWWTpHwzUa+BP0SZkfvMMKw2VnW+OzWynkd5KCmiZCKtefO+iOm2jl8gFUDtfAJjeaxkuFhAVPjpvMzse8yfe2xIzGcLyAAfsAFNY9B+nTK+xF93MzQIZzjvkDFHH3GCnwv5nGCt1oN7t5XP3fGeO7ptTDKXzQz2gXVYXWpYEePrqd3q0PjFnFQB2lmusRxwQXHkjTV+tmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9EF64BUKtbC8TpGI0xQp+wTYoYLyWCJKpsilhYtu4I=;
 b=syBdf1OgMV4jHNYtelnIni8t6hpoxuni6Ot6lTzkFiR3PDkM1W8s0XgeTuapQD/qZ7SZFGRHUheNVhwnfooh8vZfEi//aVQScHCD7Lz7aAxNbGdPDNSidYpAQqFI/Ymzep2leYIuYLt+jr0ET+XAinRgN/RziH3LgzF3qL4pQPo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9676.jpnprd01.prod.outlook.com (2603:1096:400:232::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 11:53:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 11:53:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
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
Subject: RE: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYzcqKYY4b2kXLe0WOhVN2yiYRM6305vMAgAAYvSCAATXgAIAS/ofg
Date:   Tue, 11 Oct 2022 11:53:45 +0000
Message-ID: <OS0PR01MB59223A0E69AAEAB350B609BA86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com> <YzRRJD/VTbgesoEI@orome>
 <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzVp1t7fMRBv9ISK@orome>
In-Reply-To: <YzVp1t7fMRBv9ISK@orome>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9676:EE_
x-ms-office365-filtering-correlation-id: ce673c1d-0d3e-418b-196b-08daab7f4039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6/y8bKoRhKV8rF6hkVFckjFlITvzn6Gck7Rod5JRKaVa8zM7iJ9h900a+tp/udDXgapWwBaJDzzUMtjsLbcEgMbRv4ap1c010B3qKw+eUp7JKqdSdbOy3wfIWoSgAkmZexp7LZenK3N3+HEaziCBBpZnBn7IvWGJG2r9mZq2wm60uk7vcnuSdoIuLKuRDDKdeWGid3myJeAyhlogKjXcC2fE9xX0YXL9T5qBd4yIKgmeqhbtutw3sFZCtaErechC34+gDyzwgjft8ZeNctytzAi5NuhXwK2Lhmn+nDGUIOOvxBCuQx/s6umhs8w85W+ybzowlXiiCaz2P9+PzqdLvSheayi0jA28N6UAUMTJdcdbSsJXBG0hVsRWhaQEjrJLt9WPDNtr+tQB09A580aDg/vnWi1QaM09+erOy+5p22u944yMrvbDBUQ/0Euz2oeYbYfdyVeH8PJhjaYE7G3MT2nMagmPeJ05+MmY1dsfHAqJKH1ZQ2pgr9T94nHIRYvM8NbaiHnB1ocEuwFXnZv8RIHhMB4r3bRnRbJamuLMKzd5U97hDDJ1O4OPqteErLWu8HAD8L8pxbDF2Bk8TCpF+yT2KXg8dKIa/GGad0rn2upClIYSbdmO7dqBdPe6+hgNdGh/nQl/SnueH5Fs/LCQ+DvgQrlIR0Z5PP+qOE6XGwhXiV3JyUKRRaXexDR9SM9ZptF8CGODlK4pHN1Kwn4jZtbDjBuC3IVdcZ/0bDpvXW63kAx5LGfMeG8M3NIGMYrdBieH7K1INgl40GwSatbFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(66476007)(66946007)(26005)(8676002)(66446008)(76116006)(7696005)(6506007)(64756008)(9686003)(66556008)(4326008)(186003)(54906003)(478600001)(122000001)(41300700001)(6916009)(33656002)(83380400001)(5660300002)(52536014)(38100700002)(316002)(55016003)(8936002)(38070700005)(2906002)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0dJdklXVTV1MXE5SGZYa2FZWUwycWRVL0t4bTUxQ1pOWjZmUjdTTVFqSVNR?=
 =?utf-8?B?Y1JhUVdpUW9xTEY2dndENjY2eVlMUnREbWNoeGpESXJOOHplMFN3SGNhTEhB?=
 =?utf-8?B?RjNaQUJQUDFRdUNCdHlHb0ttdFk2ZTVYZ3EzTFFlMU1tVTRRbzhDTW1OUGZL?=
 =?utf-8?B?K2dXQlVoelY2RnlOY3E2bUlSaDF3SHVzZjRkSzFxRE14Vm9CV2VFN2p2UWxJ?=
 =?utf-8?B?MUxrZmRTSXovZ2pCTk5DWVVjc01KUHBHdmI0bUNBc0VneFNPaTNKamlIalJG?=
 =?utf-8?B?SHdBYlFHaHdZZldkWG5wNUhPa0h6Y2NCQ0ZZRXUrNnhoUTR1b0pMRXRwV2ZQ?=
 =?utf-8?B?TlZBU2tFY20waUxRekR4TW8zTzA2UEs5aTI5Y2I0WGlZL0hmR0VVcXRoY1FJ?=
 =?utf-8?B?ZWMya2lSSWNaM3haSFZIUTZVM054N2F5blg0a3Raak9GUVc0SVM5RGNSb2J1?=
 =?utf-8?B?Wm5TS1Q3eS9Icmg3K1dOZTVuV0hnb2ZRVldETm5HZzhuVEMxUGFmaERUSm9Q?=
 =?utf-8?B?eDRyNlJndXIzTlFuMVllQVg4TzE4TzkvQzBvVlcxNXp1b2tQaWNQV0duNTVO?=
 =?utf-8?B?MXJuZlZBK2M4T3FUa3Q4RzYybDE0V2t3d0oxZTdaRkk1QnM2VUZEWXljZWlE?=
 =?utf-8?B?eHRVQ3lyZHNKWGFpZU1pQ3Boekp0d1JDUW1VQkNrYUpmc0FHTE03NWVWZUZw?=
 =?utf-8?B?Y3RpR00wY0lQRE5LQkxCSFBXVXpQelkwRkxRODF6QXVzMjFZY3dtRmJJNmV2?=
 =?utf-8?B?THFpdytqQ0dtd2c4RGQ5aFc1b3ovRkhFUFVqMlc4SXlJSEJPYUY2WFNiRXR2?=
 =?utf-8?B?NVRITmYvMlRLTUcyaUJYanpMcEQrWDV6aCtPYUhCRktsNTAwcHliTkt1OUli?=
 =?utf-8?B?QWVsSkJFZUxUMlJHNWhQTzZ5K0JCRlZtRUtPajZZeUJoM3dIa3RLUW5ZbkU0?=
 =?utf-8?B?ZWRoYWphZDNOenNZeHlCZHpCd05QMDdRc0xpWVJQd0ZvMHNna1BZVDRWeEFi?=
 =?utf-8?B?ZVBtWlIyVk9wMTM3NnhDdFdaYkVLTXJ4bTNvdnZ2bCtHdG9ZQ0oyWEttbUd2?=
 =?utf-8?B?S3p6SlpveldnQVFnNmY0YTZmTDhoV0FaOVgzaE5KT0hPUFRleU1VeTBPVWNq?=
 =?utf-8?B?dDYxUjFIejZPZnM3OFR2cmpxSU1vNU4wUGtjUDBkVmdNWERsZDIrSS9NZTZV?=
 =?utf-8?B?LzkwY3RaanRMR2RhdGdaN3ZzV0kyTzk4SjlGeER1T3B5S1J5YkplanJKSWRD?=
 =?utf-8?B?d1MwWVdFZ0FSTXlBVTJZUFAzS3JRSXowY1FiVHh2UTRya0FXT2IyTno4QTZk?=
 =?utf-8?B?OXZyRWFycXQ5eEVFTndpaVN4eHVNcnpiYU15R1R6ZnNLTTBNaXozNzlBcmRs?=
 =?utf-8?B?bk5YaXNYTjE5djdSNm1jUTREd1VySVNhM2VrT2dYK1MyS2FSTGQ1ZFRoT0pG?=
 =?utf-8?B?V0RFaHdYRW9CZ3FWWmZVZ3ZWamFXZ0I2b21NMGU2Y1dSbFNIZUU3WnI2Tldp?=
 =?utf-8?B?R1Z0R2Y1OEZmK1JpRVVjNW1nbW90ek5rUVN4WmpkU3cwMWREMGQzR0ZYeDJn?=
 =?utf-8?B?VXRKL1IrTzBoaTdrbXpNNXVnenVJUk9uN0hCem1aZXp2bmtMRGR2NXZtZzdh?=
 =?utf-8?B?Q1RMbkxDM1NoWGJGS1BiczdaK25Kd3B5b09Jcm1oR2xlZ3RjaHFpZVgvQW9q?=
 =?utf-8?B?V3M1MVlZZWlqNjJ4OUR5djlsbUZHUGVVYithZFBuaHB2Z2lydG5SYzV4QXMr?=
 =?utf-8?B?b0JTdzEvUWZqbEYzdzhndlNhZFFvV0RqQ3pTSjlELzdUTndKbWdGS01jMGxU?=
 =?utf-8?B?NklWYlp3U1JpZGRNaHVWTFk5N2hZSEdPT09YUmZoRzVOVzZFVnlUOHhHcDBs?=
 =?utf-8?B?OWtrUzFidVcrOWk2N2lXMzMzTlhvSDZiL0NGSjljbVZPS3F5eDQwZ09nZ3U4?=
 =?utf-8?B?NDVqU1FUV1g4WVRLWG8zVjVObWNienRDcEVkTUYwR3BHbmpxK1dPaXpSMXEy?=
 =?utf-8?B?T3FjQmlzWGswbDNHZTdXbDlQVXQ3U1FmRXkvZWduOEZSb1U3VmphL09DaWI1?=
 =?utf-8?B?SU5wdnpIZjBpOWZqdmxCL1F2VTgzcUNTamVPRk93OC9kVm01UjNiMFI1WlpZ?=
 =?utf-8?B?dy91VHFMaDJMMyt2dkExS3pua3NDMGtQRlZJaGs5WG1JWWdNUWl1Y29QSUlj?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce673c1d-0d3e-418b-196b-08daab7f4039
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 11:53:45.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77Q+Wu1XhRNzyGXIyJr8agc3mJNDEdB8O1H3WKBpXcXb9Nb0g2ugC/fkdEbWSxCNzFFgTlqnPFTp8YBy0VxtBpSO6leJBV6MnyrPpQqLS/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9676
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVGhpZXJyeSwNCg0KPiANCj4gPiA+ID4gKwltdXRleF9pbml0KCZyemcybF9ncHQtPmxvY2sp
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcnpnMmxfZ3B0LT5jaGlwLmRldiA9ICZwZGV2LT5kZXY7
DQo+ID4gPiA+ICsJcnpnMmxfZ3B0LT5jaGlwLm9wcyA9ICZyemcybF9ncHRfb3BzOw0KPiA+ID4g
PiArCXJ6ZzJsX2dwdC0+Y2hpcC5ucHdtID0gMjsNCj4gPiA+DQo+ID4gPiBUaGUgY2hhbmdlbG9n
IGFib3ZlIG1lbnRpb25zIHRoYXQgeW91IHVzZSBhIHNoYXJlZCByZXNldCBiZWNhdXNlDQo+IHRo
ZQ0KPiA+ID4gcmVzZXQgaXMgc2hhcmVkIGJldHdlZW4gOCBjaGFubmVscywgYnV0IGhlcmUgeW91
IG9ubHkgZXhwb3NlIDIuDQo+ID4gPiBXaGF0J3MgZ29pbmcgb24gdGhlcmU/DQo+ID4NCj4gPiBF
YWNoIGh3Y2hhbm5lbCBoYXMgMiBJT3MuIEVhY2ggSU8gaXMgbW9kZWxsZWQgYXMgc2VwYXJhdGUg
Y2hhbm5lbC4NCj4gPiBCYXNpY2FsbHksIHdlIGhhdmUgOCBod2NoYW5uZWxzICogMiBJTydzICA9
IDE2IHB3bSBjaGFubmVscyBpbg0KPiB0b3RhbC4NCj4gPg0KPiA+IFBsZWFzZSBjb3JyZWN0IG1l
IGlmIGFueXRoaW5nIHdyb25nIGhlcmUuDQo+IA0KPiBJJ20gYXNraW5nIGJlY2F1c2UgSSByZWNl
bnRseSBjYW1lIGFjcm9zcyBhIHNpbWlsYXIgZHJpdmVyIGJ1dCB3aGVyZQ0KPiB0aGUgbWlzdGFr
ZSB3YXMgbWFkZSB0byBkZXNjcmliZSB0aGUgaGFyZHdhcmUgYXMgNCBzZXBhcmF0ZSBkZXZpY2Vz
DQo+IHdpdGggMiBjaGFubmVscyAob3IsIGRlcGVuZGluZyBvbiBTb0MgZ2VuZXJhdGlvbiwgMSBj
aGFubmVsKSBwZXINCj4gZGV2aWNlLg0KPiBMb29raW5nIGF0IHRoZSBkZXZpY2UgdHJlZSBpdCdz
IHByZXR0eSBvYnZpb3VzIHRoYXQgaW4gdGhhdCBjYXNlIHRoaXMNCj4gd2FzIHJlYWxseSBhIHNp
bmdsZSBkZXZpY2Ugd2l0aCA4IChvciA0LCBkZXBlbmRpbmcpIGNoYW5uZWxzLiBNb3N0IG9mDQo+
IHRoZSB0aW1lIHRoaXMgZG9lc24ndCBtYXR0ZXIgYW5kIGV2ZXJ5dGhpbmcgd29ya3MsIGJ1dCB0
aGVuIG9uIHNvbWUgSFcNCj4gZ2VuZXJhdGlvbnMgYWxsIG9mIGEgc3VkZGVuIHlvdSBoYXZlIGEg
c2hhcmVkIGludGVycnVwdCBmb3IgYWxsIDgNCj4gY2hhbm5lbHMsIGFuZCBub3cgdGhpcyBiZWNv
bWVzIHJlYWxseSBkaWZmaWN1bHQgdG8gZGVzY3JpYmUgYmVjYXVzZQ0KPiB0aGUgaW50ZXJydXB0
IG5lZWRzIHRvIGJlIHNoYXJlZCBiZXR3ZWVuIDQgZGV2aWNlcywgb3IgYW4gZXh0cmEgbGF5ZXIN
Cj4gaXMgbmVlZGVkIHRvIHNsb3QgaW4gdGhlIGludGVycnVwdCBzb21laG93Lg0KPiANCj4gU28g
SSdtIGp1c3QgdHJ5aW5nIHRvIGF2b2lkIGFub3RoZXIgc3VjaCBzaXR1YXRpb24uIExvb2tpbmcg
YXQgdGhlIERUUw0KPiBleGFtcGxlIGZyb20gdGhlIGJpbmRpbmcgaW4gcGF0Y2ggMSwgeW91IGhh
dmUgZ3B0NCBhdCAweDEwMDQ4NDAwIHdpdGgNCj4gMHgxMDAgYnl0ZXMuIERvZXMgZ3B0MyBzaXQg
YXQgMHgxMDA0ODMwMCB3aXRoIDB4MTAwIGJ5dGVzPyBJZiBzbywgaXQncw0KPiBsaWtlbHkgdGhh
dCB0aGlzIGlzIHJlYWxseSBhIHNpbmdsZSBsYXJnZSBJUCBibG9jayB0aGF0IHlvdSdyZQ0KPiBh
cnRpZmljaWFsbHkgc3ViZGl2aWRpbmcgYW5kIHRoYXQgY291bGQgdHVybiBpbnRvIGEgc2ltaWxh
ciBpc3N1ZSBhcw0KPiBhYm92ZS4NCg0KT0ssIEkgaGF2ZSBtb2RlbGxlZCBhcyBzaW5nbGUgUFdN
IGRldmljZSB3aXRoIDE2IGNoYW5uZWxzDQphbmQgdGVzdCByZXN1bHRzIGFyZSBsb29rcyBvay4N
Cg0KSSB3aWxsIGJlIHNlbmRpbmcgbmV4dCB2ZXJzaW9uIHNvb24uDQoNCkNoZWVycywNCkJpanUg
DQo=
