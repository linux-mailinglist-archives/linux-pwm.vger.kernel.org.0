Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7570620C0C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Nov 2022 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKHJVj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Nov 2022 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiKHJV3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Nov 2022 04:21:29 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912B24F11;
        Tue,  8 Nov 2022 01:21:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8C4fw/cS/rXYvjbwbz2/AHFwV79i2OeQdVqYO2cqiAaUyiBLJ3Z/iHXzZnxyaYUHC8x+GjHL8ZZ/4ZSO/3cnZ+eQMt/Xmt4ecHHVwvPi0/e1CiNSkhiAVs+IIbE2i8BJBYZB9JaK8lq/QBKznuX4hLJP1jWvTYQVlBhr9ZOBDznIhNOV65b5K9qAMWmWtK0xKMnorfiDv5p8CwFp5s6zb34pM7PnFM76ZrRLieGjerHEezhE3kBeV0Jx70qcxA/8PEG5MTs/yRXLND7MsTvtCWGYvcFgdlK1FXROXeEhIuRWBTxui6KtmJuuqZ6RbXdVmB+achumoaBqLRxzcPU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79OH7v/EBV4cKW0fbg0zKZdzJnkKCH9pCmR9ZDfUG5o=;
 b=cHCU+BlKSgCNQVKquGzRYKzuSyJg8hQAla4w2B+R3J0HJWak/kbZh0mjrAh1iHb3mnms1jzorjMJthHdAes/xRzlxRWPGSwuDQA7SPy+5yp8DQqY4uRj2Me4M23Z12TCyh0PRoLAzpSeS0+PnXN2Hjs5RALpAnjixHzHYJMiPRk7I6A+sthLvwZHy7dYnHnYCGo27t0Dg0F2RBSMoPm8R9eGMxU6NlbuBlHiE6FPHWqZ9a9JDmbWPt6afCWzvAerY2oVED+RndH5y36wYmhekZiML011lgPybwJlvnL3SiMVPftkPu1kDCEVUnOdk1qR6mLGZwfiX0bcniYNGvtkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79OH7v/EBV4cKW0fbg0zKZdzJnkKCH9pCmR9ZDfUG5o=;
 b=pPzvz9l2oFM7amKlDx8wEdaMAwoNcwoITLHarVUCKl0CdIbSU+0wTCIjHOY71ijZ3WvhnjcTxqx5yyoJCyCl7G/IH6lIiNYhNxc/o1XR3ksRZ/97bCpct8niat8itB9cgdLBBW1hy2CTEvixV9mI5otef48WboWvnAOyIWFkrmU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8125.jpnprd01.prod.outlook.com (2603:1096:400:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 09:21:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 09:21:25 +0000
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
Thread-Index: AQHY8szyFfdaz8EsEkCQ+VPSMc5Sy640wA+AgAAAqWA=
Date:   Tue, 8 Nov 2022 09:21:25 +0000
Message-ID: <OS0PR01MB592224E8BACCF03EC3FFE615863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221107171809.2797499-1-biju.das.jz@bp.renesas.com>
 <20221107171809.2797499-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVaY5j--jSc2WUZ=Mmyr83RFvNiTNXKzv3fUSPk9wsKqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVaY5j--jSc2WUZ=Mmyr83RFvNiTNXKzv3fUSPk9wsKqQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8125:EE_
x-ms-office365-filtering-correlation-id: 672ed1c4-8299-4f5f-13c6-08dac16a9bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayYzwow4GsujipdkmIR9QJ+K2QaVm/TOrsAAlKzWVTlhfDafk63VNJnjuUqJvwjBN8Zn6eYiEAJjMh61MMQCmFOdvjWOIbx9oyOdMK1lYAFQfQtFBepqTVBlpctgvmBeI+rduKnnLg+EMonXZoBStGQkLQlGHUsUPt6ArZbtkO7iis77zpUJC45GkeS18oSrL4GaTrjGxBNFoUf0qmCD3NHRtI+kQZozJLBj0TSBCIYJT5zs6j2UwJ5tTo2xbxH7WMcAZmJd/FNsNFPI6ZkY5S18N57tVL26N22AOjuv7lF9Cjtc358iYcbk1QZ7jl/U3W5DZPKAiLdUUsowlmFrajP3AI26xJaI5C+9ryxjK84CI6QoWrR8vOhUswFE5bW2aQeHwiZnx1rPG0j9KAlyPnQgZ+Flf4lKMqvJ4ZXrKb/+i0pN8lG65+cirarIE8sw2uJkcSNaZG8MbObrKBMJWWl6dkaTW5SorjbTPZq3UoIP85qKTpNPwf4jdEy7xprc3jC8iBotOGo78Xu5Bm8w/rbO3dSj6LWu0HXd81FwgsJsrBRj5FqGpJPwPj2DAUntJlWrZ2GQrkOC6tbuwRm909UReKBFuZeLk4OkYMbXBbwZGyMxcHZ52+4utD3DSg7Nw/EkF6hTFGylb9fwJX5cKqqIMz0HUjWH9N18DPugnAqAdkHNl3KFHYKnR2AaMGGkSduZo3NMFMulZ2G7lEyoFUWN8AQLI9WvI15p/mUTg6cNY4yFK2QKfIjeGQSMiFpLBRtRpTwM7rXDrPCPzDjOYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(5660300002)(8936002)(52536014)(41300700001)(38100700002)(8676002)(64756008)(66476007)(66446008)(66556008)(66946007)(4326008)(2906002)(83380400001)(316002)(54906003)(6916009)(86362001)(33656002)(76116006)(55016003)(7696005)(478600001)(71200400001)(38070700005)(53546011)(6506007)(122000001)(26005)(9686003)(186003)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWhQY202NzFnV2lzaytVOVp4dGd0aldrc2lvZW5hVkNGL0M1Njd3T2lMVjhS?=
 =?utf-8?B?RGF6MTJjQ1lJb1hSQldmdFZvU3NOWC96YWFXTEw5Ri93QlhpbDQyN1llaDNY?=
 =?utf-8?B?Q2hhK3FRVHo0M3VaMlF6LzdEc3RmOGlYL28rSGpIQVNBM29HSzJvcmp6MXJT?=
 =?utf-8?B?S3A3U0U4enE0WUM4N3FVcUR5SHRiS1dFam11bE9tWjZVVmd3bXR1WDl5bWhr?=
 =?utf-8?B?dUl5TWl3azM3ZENWN0RBc2N4OUVFZ0xjUXFsazVPV2tDSFRUN3JkbUpqOVRq?=
 =?utf-8?B?SHVRUWNIcFBCaVFGVU05dDlOWXc3L3hCTnlhallqcHZUMzltZkVMeWJBSGxn?=
 =?utf-8?B?YjJXNDNySEN0aUlJZWl5bWFBRTAzVEQ5OC9mVDlkQkVxamMveVZHVHljUEpw?=
 =?utf-8?B?Q2FUMmV6VlpDQlVpYVRZZWVxVEpyakl0TVJVRE8ySzE0REw1VEFoSUh4Nzkr?=
 =?utf-8?B?S3N1dWtBSzRFZ2N5SGZOWkRNeEN3WDJkbFlpV2dIbzhaSTFvcUJVZUkzdEZy?=
 =?utf-8?B?S1J0cVJaQ3FJblF5S2pjeVlXM3FpZFJLdW93V1lTc3ZWUm1peFdJbU9HV25o?=
 =?utf-8?B?amlLV3ZRZG1qYTJPaDFBL1d2L01udXJDZHFrTGJ4bVNnejUzemREMTlLNU1v?=
 =?utf-8?B?U2lkSmRkRDRlUm1oS0xnOG9YQ2lvSzdUeE5GS2ZrN1QyMC9MUVNIa2pDWENH?=
 =?utf-8?B?MkUzYys0T1o2NTU2T09MUGtVcEFaT3V4SWFVZDhRU2hUQWpGNExnaFRJelBt?=
 =?utf-8?B?aVhSYk10aTZVNFd6ckQrVG1BcWtkVnljRG5wTzJ0amhWM0s5V05OemNLK2tw?=
 =?utf-8?B?ZGJGZzVyZ1I5U29UQVhZaG82Z0lucTQxanBoeDJHY2VPU3d0L2IzSmJTWGVE?=
 =?utf-8?B?ZEpNcXJ5R2hNOFRmMXp1U1N2R0IvekhqL0JSU2c1VGdHNjltL2NDbmN1aVEr?=
 =?utf-8?B?SUpYRFJXeDl1bjVHRktHa09YbHdOTXNyRnBOdTlFUzJkMURVcTdHU2ROS20r?=
 =?utf-8?B?VTQxS1NoN2lXMDJ6dklyMHJKalpWS2pDaTJ4YlJnL1lCV294by9MVXcxc1Yx?=
 =?utf-8?B?REhSRnVCVlp3Z3dMUFpTM3ZyZjkybCthRDBQdjhsZkd5bmNHSnZYNUg0VUpy?=
 =?utf-8?B?cFluUHZzYTVWTGM5dW5uSXZPTEFCK05ROWFFc21NMEdkMnU3OEYrZis2MnlR?=
 =?utf-8?B?dU1PTkM1ZmRkTzIzNGFrM1ZVVGIzdjE3dTcwdzNqSWtLbVJSZ05tV0VrTW9U?=
 =?utf-8?B?S3VVYklMZmpTcDE1N3VmeVZ3RVFiOCt2dVcxMTlxYS9HMXpSczFoS0YybHhz?=
 =?utf-8?B?VmsxSVhKT3BOeDNDUGIxd3Fudy9GVXJ6bDZRekQrRnFkdFFRbVlsZUpBMGVF?=
 =?utf-8?B?WWtGZElxNHVsc2EwQ3RqcE5xZkx3b2VkWWdZMTZsZ3BHS1JjaUZybmlrMG5I?=
 =?utf-8?B?amV0alJjUUxyVi9aYnlJWG9OdVgrTFY1SDFQTHN1bDlqSDJxTW5Uc3d1dDAr?=
 =?utf-8?B?WGxVZWpWZGwvcldEZTVvc2lTS05tUGJpQWdhRlFobXRDM2tabDRmTDQ4Q3RU?=
 =?utf-8?B?K3R4elk2anh3Zm45QnlGd29sbUVzRlJlL0hlK2Y3RjhQSXhmcUNSN3RqOCtG?=
 =?utf-8?B?TWNKeEx4dEZUUzRwNFNCdU8ySVVudENYMmwybTREaUlSUUs0ODYzRzdyT2Er?=
 =?utf-8?B?eWo2d284UG1sZ2xaSGRLVDRNRnJYK1l6bVZtMUcvbTlidUlzdGJxeGViWDdo?=
 =?utf-8?B?Y0pGbEpRVFBRZ2pWbjQ3MU5aVUFQL0I5cFdnYVFtSmxLTFJzdCtMSHVkdk1t?=
 =?utf-8?B?WEdZN2VQcHNNY3lyNEFWQXg4dHdaVnliQzV5YVFjWHFFTFQ1dUF6d3lZdnlE?=
 =?utf-8?B?eVZFaGtqRGs3Qnk0d0Vob0s5YWZIWnVLSDlYRVNUS2pPTUgrSEVjNnlFb0t1?=
 =?utf-8?B?SVJCc0hpZ2JFbGNUMytHQlBmZDhsLyt1dzVIQzZiVGNmanB0ZEp1WTFmTExJ?=
 =?utf-8?B?QzY3QzkzZnNXZVlnKy9GYlFwNENwUnM2ZVlSbmd5c1B3TzBmWi9KRXM4MHhB?=
 =?utf-8?B?NnZwU0pSWGcwZGxGMWU0aEF5WE0rc0t0Mng0QzF0WloxeXJMbDFDdWZzaVBW?=
 =?utf-8?B?RWlZWE8reWhHUkRYQWttVFlkMHBhOC9iZ1N3aGFiOTRBTytSZnVWclZxRzZn?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ed1c4-8299-4f5f-13c6-08dac16a9bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 09:21:25.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMJkYSVI66S5uen0FfQruDj8Rc3TN5lUo1onOw3ZOH80GxgadMJW3j+xKpnYlqI3eh8x7jAjCfXCtNFnh4ei+DbuGjwI23lnTnRCmNaiTo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDggTm92ZW1iZXIg
MjAyMiAwOToxNw0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiBDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47IFBoaWxpcHAg
WmFiZWwNCj4gPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPjsNCj4gbGludXgtcHdtQHZnZXIua2VybmVsLm9y
ZzsgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47DQo+IENocmlz
IFBhdGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcw0KPiA8Ymlq
dS5kYXNAYnAucmVuZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5t
YWhhZGV2LQ0KPiBsYWQucmpAYnAucmVuZXNhcy5jb20+OyBsaW51eC1yZW5lc2FzLXNvY0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMi8yXSBwd206IEFkZCBzdXBw
b3J0IGZvciBSWi9HMkwgR1BUDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCBOb3YgNywg
MjAyMiBhdCA2OjE4IFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3Jv
dGU6DQo+ID4gUlovRzJMIEdlbmVyYWwgUFdNIFRpbWVyIChHUFQpIGNvbXBvc2VkIG9mIDggY2hh
bm5lbHMgd2l0aCAzMi1iaXQNCj4gPiB0aW1lciAoR1BUMzJFKS4gSXQgc3VwcG9ydHMgdGhlIGZv
bGxvd2luZyBmdW5jdGlvbnMNCj4gPiAgKiAzMiBiaXRzIMOXIDggY2hhbm5lbHMNCj4gPiAgKiBV
cC1jb3VudGluZyBvciBkb3duLWNvdW50aW5nIChzYXcgd2F2ZXMpIG9yIHVwL2Rvd24tY291bnRp
bmcNCj4gPiAgICAodHJpYW5nbGUgd2F2ZXMpIGZvciBlYWNoIGNvdW50ZXIuDQo+ID4gICogQ2xv
Y2sgc291cmNlcyBpbmRlcGVuZGVudGx5IHNlbGVjdGFibGUgZm9yIGVhY2ggY2hhbm5lbA0KPiA+
ICAqIFR3byBJL08gcGlucyBwZXIgY2hhbm5lbA0KPiA+ICAqIFR3byBvdXRwdXQgY29tcGFyZS9p
bnB1dCBjYXB0dXJlIHJlZ2lzdGVycyBwZXIgY2hhbm5lbA0KPiA+ICAqIEZvciB0aGUgdHdvIG91
dHB1dCBjb21wYXJlL2lucHV0IGNhcHR1cmUgcmVnaXN0ZXJzIG9mIGVhY2ggY2hhbm5lbCwNCj4g
PiAgICBmb3VyIHJlZ2lzdGVycyBhcmUgcHJvdmlkZWQgYXMgYnVmZmVyIHJlZ2lzdGVycyBhbmQg
YXJlIGNhcGFibGUgb2YNCj4gPiAgICBvcGVyYXRpbmcgYXMgY29tcGFyaXNvbiByZWdpc3RlcnMg
d2hlbiBidWZmZXJpbmcgaXMgbm90IGluIHVzZS4NCj4gPiAgKiBJbiBvdXRwdXQgY29tcGFyZSBv
cGVyYXRpb24sIGJ1ZmZlciBzd2l0Y2hpbmcgY2FuIGJlIGF0IGNyZXN0cyBvcg0KPiA+ICAgIHRy
b3VnaHMsIGVuYWJsaW5nIHRoZSBnZW5lcmF0aW9uIG9mIGxhdGVyYWxseSBhc3ltbWV0cmljIFBX
TSB3YXZlZm9ybXMuDQo+ID4gICogUmVnaXN0ZXJzIGZvciBzZXR0aW5nIHVwIGZyYW1lIGN5Y2xl
cyBpbiBlYWNoIGNoYW5uZWwgKHdpdGggY2FwYWJpbGl0eQ0KPiA+ICAgIGZvciBnZW5lcmF0aW5n
IGludGVycnVwdHMgYXQgb3ZlcmZsb3cgb3IgdW5kZXJmbG93KQ0KPiA+ICAqIEdlbmVyYXRpb24g
b2YgZGVhZCB0aW1lcyBpbiBQV00gb3BlcmF0aW9uDQo+ID4gICogU3luY2hyb25vdXMgc3RhcnRp
bmcsIHN0b3BwaW5nIGFuZCBjbGVhcmluZyBjb3VudGVycyBmb3IgYXJiaXRyYXJ5DQo+ID4gICAg
Y2hhbm5lbHMNCj4gPiAgKiBTdGFydGluZywgc3RvcHBpbmcsIGNsZWFyaW5nIGFuZCB1cC9kb3du
IGNvdW50ZXJzIGluIHJlc3BvbnNlIHRvIGlucHV0DQo+ID4gICAgbGV2ZWwgY29tcGFyaXNvbg0K
PiA+ICAqIFN0YXJ0aW5nLCBjbGVhcmluZywgc3RvcHBpbmcgYW5kIHVwL2Rvd24gY291bnRlcnMg
aW4gcmVzcG9uc2UgdG8gYQ0KPiA+ICAgIG1heGltdW0gb2YgZm91ciBleHRlcm5hbCB0cmlnZ2Vy
cw0KPiA+ICAqIE91dHB1dCBwaW4gZGlzYWJsZSBmdW5jdGlvbiBieSBkZWFkIHRpbWUgZXJyb3Ig
YW5kIGRldGVjdGVkDQo+ID4gICAgc2hvcnQtY2lyY3VpdHMgYmV0d2VlbiBvdXRwdXQgcGlucw0K
PiA+ICAqIEEvRCBjb252ZXJ0ZXIgc3RhcnQgdHJpZ2dlcnMgY2FuIGJlIGdlbmVyYXRlZCAoR1BU
MzJFMCB0byBHUFQzMkUzKQ0KPiA+ICAqIEVuYWJsZXMgdGhlIG5vaXNlIGZpbHRlciBmb3IgaW5w
dXQgY2FwdHVyZSBhbmQgZXh0ZXJuYWwgdHJpZ2dlcg0KPiA+ICAgIG9wZXJhdGlvbg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBhZGRzIGJhc2ljIHB3bSBzdXBwb3J0IGZvciBSWi9HMkwgR1BUIGRyaXZl
ciBieSBjcmVhdGluZw0KPiA+IHNlcGFyYXRlIGxvZ2ljYWwgY2hhbm5lbHMgZm9yIGVhY2ggSU9z
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+IC0tLQ0KPiA+IHY5LT52MTA6DQo+ID4gICogVXBkYXRlZCB0aGUgZXJyb3Ig
aGFuZGxpbmcgaW4gcHJvYmUoKSwgY2xrX2Rpc2FibGVfdW5wcmVwYXJlIGNhbGxlZA0KPiA+ICAg
IG9uIHRoZSBlcnJvciBwYXRoLg0KPiA+ICAqIFJlbW92ZWQgY2hfZW4gYXJyYXkgYW5kIHN0YXJ0
ZWQgdXNpbmcgYml0bWFzayBpbnN0ZWFkLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0K
PiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLXJ6ZzJsLWdw
dC5jDQo+IA0KPiA+ICtzdGF0aWMgaW50IHJ6ZzJsX2dwdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgICBERUNMQVJFX0JJVE1BUChjaF9lbl9iaXRzLCBS
WkcyTF9NQVhfUFdNX0NIQU5ORUxTKTsNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICsgICAgICAgLyoN
Cj4gPiArICAgICAgICAqICBXZSBuZWVkIHRvIGtlZXAgdGhlIGNsb2NrIG9uLCBpbiBjYXNlIHRo
ZSBib290bG9hZGVyIGhhcw0KPiBlbmFibGVkIHRoZQ0KPiA+ICsgICAgICAgICogIFBXTSBhbmQg
aXMgcnVubmluZyBkdXJpbmcgcHJvYmUoKS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAg
KmNoX2VuX2JpdHMgPSAwOw0KPiANCj4gYml0bWFwX3plcm8oKSwgd2hpY2ggd2lsbCBiZSBvcHRp
bWl6ZWQgdG8gYSBzaW5nbGUgYXNzaWdubWVudC4NCg0KT0ssIFdpbGwgZG8gaXQgaW4gdGhlIG5l
eHQgdmVyc2lvbi4gV2hpbHN0IHdhaXQgZm9yIG90aGVyIHJldmlld2VycyB0byBnaXZlIHNvbWUg
ZmVlZGJhY2sNCmZvciB0aGUgY3VycmVudCBwYXRjaCBzZXQuDQoNCkNoZWVycywNCkJpanUNCg0K
DQo=
