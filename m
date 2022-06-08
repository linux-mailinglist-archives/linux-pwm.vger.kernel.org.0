Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D0543A0F
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jun 2022 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFHROr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jun 2022 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFHROX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jun 2022 13:14:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338D1D01EF;
        Wed,  8 Jun 2022 10:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHRe8Kxe3FYF+5FGt99EmeBayAfucYnrHRscRXRi6tsMcMlSfsa9rXwnzabo9uDFlXRPMhtRRAFUykM02xUeUz4+DWtE+Agf9Aok1BB5mSZBc1l7ov7sU0VNA9Ri2iq+mhYMfm1haMBTb1DtwecmG0lOwfkC1yoaUZl8UfztcHGc1UOMIM3Sd3CRHWNHuZaBqYTlQWnq5HtCuXXbvnmNv+wa1bsvRBhG4qYYr5ALp59qggZScfYHWI/ZPDfU3O+S1EPCjlDSexdGnFpFVtPqJJHpsbqVDR03P+fOVBLOmfcUfg76lmCBDmuG2hRUNmyNTAL53tS4rCg0wnNB7uSmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j+FLAW+F2gWJDSzBkO6Cgwa9rWXC5YBwClj2kuaYlQ=;
 b=iteby6sZ3H1RYFFA3jqud5CYbUz2MoRDV1aRm8EmvLV22CKiHjV61fXAgb77ODV8DlqD5kX1wRpncxYgfDU9O0nNtth6QJKt77jUoGd/7nRXBknApbs+SudKEsdY9SK8BTlHctTALvR4sLCqHzsIExxelySjzWH3zkYb1LTmGoFd7e/up8ARflVyTcsHGGwXk7CuKL2vNTlLkJQwhcYfYOQsYnGrJnbWELDvWsBMG4Jkd3jpPm+fmwdrP41AWLdzNqXw+f8oW4I8vN9/1ff9aDcI+ebRwSprFw5Us/IlU/fJeCZpC4iOBx9/OzuStfIQfSsoQQtPbZPthfpap+hcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j+FLAW+F2gWJDSzBkO6Cgwa9rWXC5YBwClj2kuaYlQ=;
 b=crdefOCZcUE/lk3ugxMMVR4fLCOnEd9Q3uzqG/FFVvUt2idRWYr7sywijn7Fg4j6R78oPyc4IKj2xuA/JR75JB8ZZEHxV9oWpD5w/MOqLW8zgbk0qD/PjFDIQrkxXqDvZbpPTyWOLLyimEPebbtP/rXQ+z5tIIeaCmRLm8Q0M6g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4758.jpnprd01.prod.outlook.com (2603:1096:604:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 17:01:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 17:01:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [RFC 4/8] pwm: rzg2l-gpt: Add support for linking with POEG
Thread-Topic: [RFC 4/8] pwm: rzg2l-gpt: Add support for linking with POEG
Thread-Index: AQHYZIA/M8FiyQKD3kO+g/JSjumGgq0l+OAAgB/wJzA=
Date:   Wed, 8 Jun 2022 17:01:23 +0000
Message-ID: <OS0PR01MB59223648F275B8EC4085513386A49@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-5-biju.das.jz@bp.renesas.com>
 <CAMuHMdVoQ9rjOuubLYb=6j_LP=qVeG+u0nxmqh_Pkr+jDPWLUw@mail.gmail.com>
In-Reply-To: <CAMuHMdVoQ9rjOuubLYb=6j_LP=qVeG+u0nxmqh_Pkr+jDPWLUw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c161f1-f79a-44d1-018f-08da497084db
x-ms-traffictypediagnostic: OSBPR01MB4758:EE_
x-microsoft-antispam-prvs: <OSBPR01MB4758048B27E97C6E896460DB86A49@OSBPR01MB4758.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HyZ9ojc3jdlgJpbPgRgIqd+alceAs6TN4hL6ScOCQLf9Noa2I48BTe99McyMwRntIYI3zC4cCi1tilASUwWNR9t4kDjL6e/VoIjcgY30hb40Kf/12Q8Ly7lvlzjUgD5yulOgEee0zh3MCsGshnZInqFlPO8dVnWYeBWDRW/N1AjjAc6Ys8TRVLIcdYpuF/9EdB5anznl8f4SwrHNXIqELvnkXPuur1Bmm3Rcr+oblLhyMGzB2vLDpZwXl8tmS2QdcUnOx4BTDSXLh5/f6bO5WLxEJHrISCAvl0OVItKsGeriUckPDANzRuqbdDMdxnaLL6u+Y8kYVvLZy+fIqk6jABKPapcd4Zm7HhAGKTHZiZ4Fs5ZZV0j5QylIoKBnIqbzHe2kEmufq+8qd7RdDcM3Ub+pMKVG5+1jvGkZ2n6vrnnRLeWBB1jEUCcXPhQO5ApoV2+oMLjEZK2y1CGdkVYWKVeEMMn+4Ll1ebjH6r1qIfKo/xAO5NNIsdG69ueHUtV8l1hZwJF3otbGRnYEnZ8sUDY34QpurcOacPZPPOFcu5fOGZ1RnNtnHVTVsKEjypd+fVzhJUwVQCi/weEfy3Z2RxlJG4LsPdp5GQd5a0/Vx3wpS/hWR2CU6NG+pH/rqOLwoiekEaq7Uej0NJ/oZPL81i+qQcQWrDiVSUwvElqDEFQXlqAfplizqohiAdrrmg4iOvWtbieB9Jo/ZJA0umxjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66946007)(316002)(53546011)(4326008)(8676002)(33656002)(7696005)(71200400001)(66476007)(2906002)(6916009)(9686003)(86362001)(76116006)(66556008)(64756008)(66446008)(6506007)(54906003)(55016003)(26005)(52536014)(5660300002)(38070700005)(38100700002)(122000001)(186003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHFaSDVFSk4yaFlhSGtxMUZPTVR1dFViUDVRY0FCNnpwU1NMQWpRdzdKMXBI?=
 =?utf-8?B?SjNuVDBWbU01L0gvSERXMmo2ODBLeTNnTWhvZTcwTXorRVdmbnFTSklmaFRW?=
 =?utf-8?B?dStvaStmMGN4RzNSL3ZhM0tSY2hlOXZPQTVOZmt2dzFtYlo0M3hoOFlPa1JZ?=
 =?utf-8?B?cnBFRFNjNXIrejJHMTgrSS9tdkZINUtsWk9BUHQwSGJWd1FHSUNxWWtOS1c5?=
 =?utf-8?B?MndaR2ZPSXcvVzFKR0Y2MGx3R2g4UW1IbVU3eHB2di9yZWhBa1BzMXl6a3lo?=
 =?utf-8?B?OEhKZmxUVGU1cCt0dm9lT2I5aTNYSzhVQVVQcW1XbTlNbHQxOUdNK3l5Tkxl?=
 =?utf-8?B?Ulp4NDNJa3Y2S1c0ZVo1aVRUSHREZVB2cnhJWXQxa001RU9yaHQ1RjBERlRQ?=
 =?utf-8?B?blRweXVhdEdUQ3lpdUJjazgwMXMzcVUrak1uZnZETzlHUFhRN1FhcUFuK09R?=
 =?utf-8?B?ZWUrNXROMExiRllXdUxPWko1Yi82aUpWc25XTGU1b2g2dldMcFAwbU0xV0Ev?=
 =?utf-8?B?Q0M0Mmp4Q012ZjR5REJsbUJ5aGlHUkZad1pKQnBjaW9GeDBOVkZkaE1XRVpE?=
 =?utf-8?B?cTMwS3FNM0FDcFliQ2NXckx5c05lWU9WUkhqMFg3TjF6NS93enpyUTVLTk5V?=
 =?utf-8?B?NDhaNWxoVklTdGxkRzAwaW1YaDQ5MzRtY0phTGJTM1ZSV0hkeENZaVIxNlZF?=
 =?utf-8?B?UVVGaEpTUHBGRFBmWi9qdjMxd2JvRE9WTG5LeDY3eGxKZFZaa0s0dnNySnJp?=
 =?utf-8?B?ZjM0dHE5SENYUFBtVUN5S1hWK2c5T3c3eUJJaFRkL2thaXpENjhoZGtSL1N1?=
 =?utf-8?B?cTM5Yms1aUZWZkFyTDV4OTFBemNoRzJ5S3R1TzdIZzRzeC9UVE5GSE5XRWdG?=
 =?utf-8?B?SDRrZm40TXc0WG5tTnNrWkVqQTBHSE1SUk5kV3hXOFpzSUdSU0x5b0hOU3pG?=
 =?utf-8?B?Z21OTXBNUHFya2Q4NWRYL1lLc3pVbkJNZkQ2a2xxUEdFS3hOLy8zd0M5bHNT?=
 =?utf-8?B?YkdHVEg5ZjR2NnNIR3N5OUtGT0tNbUR4K3ZkQURFaHNlL1pRRi9GTUJXWThL?=
 =?utf-8?B?TVQ0bG1lTHFJOWVRRVdHRExnZnFtbExwVyt2MC9idUFTSUh4ZlNUQUg4TWQy?=
 =?utf-8?B?ZG4zamtxOHpJcklCZnFibFZSeCs3dHpXdmlOWnNtM0N2cWhybmxWSVZZYmhh?=
 =?utf-8?B?Ylk5blRqa3AxS0Nxd25Zckcza0h1dlNlcmd1azc5SFJuU2dGNFhkZ2psVTVh?=
 =?utf-8?B?WTJiVmdKc3hsNlVEY1Y5R0Zpd1phemZGK0pDNDh3SFczNnduYXFObUZ4WXJU?=
 =?utf-8?B?eU8rV2VGSko3SGRxRXkrNEROUHQwNEVSRWVjNm5PVm9MRkdNQXRDQ29XRzBi?=
 =?utf-8?B?NlZPRXNnRU1nK09EZmdML2lJbVdpUE1RWHlZQ1FpS1gvVlAvaVFCZnIxOWxY?=
 =?utf-8?B?UDFvdXRDcUZyZzhIUUEyVy8zaTduWFBGRGFlKzFpbG1jN3BTUHY1ZWVEaXNj?=
 =?utf-8?B?L3JxaHB2Q3B2MDNPWGY4S1owc3FocDZPQmdrbjNtWXk4YjNkenA3WmNpZ0x3?=
 =?utf-8?B?V3o3NjJia2pITHhReVd3eFpCYkh1aXllYVhvbEQvMEw3MG9Zb2M5bXkwLzhG?=
 =?utf-8?B?SGRMTitKRnd0UTI0QzJHZWx3eUJGMll1T3oyaVFrUTE2YktwQmFidlNuSVFm?=
 =?utf-8?B?aHlETTBudytld1BkZlMvS0pBK2hJR2RGQ2NlWFZ0V0drekNaa3FSZWp6QzVS?=
 =?utf-8?B?S2hyQ0p5bHc4Z2dWT1AzUXliTUdWc2xUbmNCRTlmcm1EVW5oZ3JhUE5xRlVE?=
 =?utf-8?B?R0Qwc1gyelJXbFU2UHVDT21JeDE1amVMeTJHZG1nY3pNWXJzWWwxYUU3dUkx?=
 =?utf-8?B?UmZhZG1Dd3VQYWlVRkRaQStkWWcwNlVZdU5ER21lQ2k2OXM5ZWxBb1grQktu?=
 =?utf-8?B?UDVScmdkaFFSTDhoWXdkV2xmb0pHR1l2TVNibno3dmRLbWxtQ1o2ais3cFl1?=
 =?utf-8?B?OER1MHVIN3I3MUp0S2h5QnpnN3V0cHFUMkg4YjZTZFZmaE1IU2xRR1FmUUdz?=
 =?utf-8?B?UWhKU3VPdmNNRnVjT3doWUZIMkREOTFIYVV0YTUwLzI4R2d4eDRKVWdLamFr?=
 =?utf-8?B?ZEtUNXRsTEQvSG1RZTQ2TWpQYXBwWVBoblZBR2JvWXVrREdOZnZ0RG80NVdL?=
 =?utf-8?B?a0dHdUcxcGFta250MGYxR09PdGVBRGk3cGNzNWQ3YWszQUszWmZHdmpCbnNH?=
 =?utf-8?B?ckIzMXhVa1V0TGFSaXhieVhPY1V5VU91VldoWlFRL1NEOTdBQ1ZaTmtWL3dW?=
 =?utf-8?B?bG5GMkFKenBja1dVeHptNDRiRTcvYUpoVDBub1hOUElQYS9LUXUrS1FIZkF4?=
 =?utf-8?Q?1Qkjpe5KGEXnt9EA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c161f1-f79a-44d1-018f-08da497084db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 17:01:23.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mn1yMRsoSeG/ERMwN+GPcAPfxdbWVf5Sjt3M/0w6umI1vAlor5hjj7fUCUfrnAKu45ixz1gNTXopQbS5BX9ltWkyAe8EuGOaeHCNOEXVZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4758
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UkZDIDQvOF0gcHdtOiByemcybC1ncHQ6IEFkZCBzdXBwb3J0IGZvciBsaW5raW5nIHdpdGggUE9F
Rw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFR1ZSwgTWF5IDEwLCAyMDIyIGF0IDU6MTEgUE0g
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBUaGlz
IHBhdGNoIGFkZCBzdXBwb3J0IGZvciBsaW5raW5nIFBPRUcgZ3JvdXAgd2l0aCBwd20sIHNvIHRo
YXQgUE9FRw0KPiA+IGNhbiBjb250cm9sIHRoZSBvdXRwdXQgZGlzYWJsZSBmdW5jdGlvbi4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9w
d20vcHdtLXJ6ZzJsLWdwdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLXJ6ZzJsLWdwdC5j
DQo+ID4gQEAgLTI2Niw2ICsyOTEsMzYgQEAgc3RhdGljIGludCByemcybF9ncHRfYXBwbHkoc3Ry
dWN0IHB3bV9jaGlwICpjaGlwLA0KPiBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiA+ICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgcnpnMmxfZ3B0X3Bh
cnNlX3Byb3BlcnRpZXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByemcybF9ncHRfY2hpcCAqcGMp
IHsNCj4gPiArICAgICAgIHN0YXRpYyBjb25zdCB1NjQgcG9lZ19ncnBfYWRkcltdID0gew0KPiA+
ICsgICAgICAgICAgICAgICBQT0VHX0dSUF9BX0FERFIsIFBPRUdfR1JQX0JfQUREUiwgUE9FR19H
UlBfQ19BRERSLA0KPiBQT0VHX0dSUF9EX0FERFINCj4gPiArICAgICAgIH07DQo+ID4gKyAgICAg
ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGk7DQo+
ID4gKyAgICAgICB1NjQgYWRkcjsNCj4gPiArDQo+ID4gKyAgICAgICBwYy0+cG9lZ19ncnAgPSBH
UlBfSU5WQUxJRDsNCj4gPiArICAgICAgIG5wID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5kZXYu
b2Zfbm9kZSwgInJlbmVzYXMscG9lZy1ncm91cCIsDQo+IDApOw0KPiA+ICsgICAgICAgaWYgKCFu
cCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KCFvZl9wcm9wZXJ0eV9yZWFkX3U2NChucCwgInJlZyIsICZhZGRyKSkgew0KPiA+ICsgICAgICAg
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShwb2VnX2dycF9hZGRyKTsgaSsrKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGFkZHIgPT0gcG9lZ19ncnBfYWRkcltp
XSkgew0KPiANCj4gTWF0Y2hpbmcgb24gYWRkcmVzc2VzIGxvb2tzIGZyYWdpbGUgdG8gbWUuDQo+
IE9mIGNvdXJzZSB0aGlzIGlzIGNvZGUsIG5vdCBEVCwgc28gaXQgY2FuIGJlIGNoYW5nZWQgbGF0
ZXIuDQo+IA0KPiBQb3NzaWJsZSBhbHRlcm5hdGl2ZXM6DQo+ICAgMS4gVXNlIGEgbnVtZXJpYyBw
cm9wZXJ0eSBpbnN0ZWFkIG9mIGEgcGhhbmRsZSwgc28geW91IGNhbiBzdG9yZQ0KPiAgICAgIGl0
cyB2YWx1ZSBkaXJlY3RseSBpbnRvIHBjLT5wb2VnX2dycC4NCj4gICAgICBUaGlzIGxvc2VzIHRo
ZSBsaW5raW5nIGJ5IHBoYW5kbGUsIHRob3VnaCwgd2hpY2ggaXMgbmljZSB0bw0KPiAgICAgIGhh
dmUsIGFuZCBtaWdodCBiZSB1c2VmdWwgZm9yIG90aGVyIHB1cnBvc2VzIGxhdGVyLg0KDQpPSywg
d2lsbCB1c2UgYSBudW1lcmljIHByb3BlcnR5IGFzIGRlZmF1bHQgUE9FR0dyb3VwLg0KDQpDaGVl
cnMsDQpCaWp1DQoNCj4gICAyLiBBZGQgYSAicmVuZXNhcyxpZCIgcHJvcGVydHkgdG8gZWFjaCBQ
T0VHeCBEVCBub2RlLCBjZnIuDQo+ICAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL3JlbmVzYXMsdmluLnlhbWwuDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcGMtPnBvZWdfZ3JwID0gaTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAg
ICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmIChucCkN
Cj4gPiArICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnApOw0KPiA+ICsNCj4gPiArICAgICAg
IHJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4g
LS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBt
NjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBw
ZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRv
IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtl
IHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFs
ZHMNCg==
