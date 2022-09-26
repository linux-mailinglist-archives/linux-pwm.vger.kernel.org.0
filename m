Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424C75E9B8B
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiIZIDq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiIZIDU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 04:03:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C7237D0;
        Mon, 26 Sep 2022 01:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbSjAFGGsYRR0b7LzIkj+KW0wOKalvwsOXwl1Ymer5JmwtxTKinJ2kh0TvBrpCdWhF9VZeQz/VZXcMIiMZhiEKC72Z4X0GdWMDlWvg5CWt+6dgX4F/PiS9l/+191TC6PTxKD1FQCsSEntnutxn1630wQwLvgXutON5ljymVoEdYP+NY+09WdsdRiZcvhoGSHB7aefkzZL6Dexevf7yUi462MAzdGFQVkim2C4Eo7qC4w5dwKPZVGZb62yZGOcSp6pOtXfOVddYSNdJ416WMLeRm9WBBoVd7PHVcdWoSJKXUZgIh2JEPQzKShWSogsWGQsfMch4UNSbVij0JOC69k9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boPHlcVOvVy4IAKcT+m7o+djuA0YgpYhjKjJTGHmprU=;
 b=GaZxt72LUkzBM9OClt9L6yVQqrfyMzQ8wQ6c2+pEsdml7sHeYncOrPmy4A66w1cwQ5zu15PWEZALTz2iO5AlrSfTZ6v/AvpTM8j2BbVYy4BBD8w4BqnZDkmzaND3MxQmOw5Z4i+/1+KeDaeT/u+rwFQBD1vEPIo/RAF4e1XEusmEilG/3ufzHq3BSV9t7b0Zc1bW8paEcH0vtxB56J0iCcYpfgcNR477IvU1A1aNghIqGf/U0HKXKU9U35ptrGO1NyE9ahzQ3/SDAz/cj0IHJ8gyL+tU6IzlUBTuijdiavlX5FQTWC4FMrPCetJDh04R8tzocZ6tdkFSEBvvyXewgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boPHlcVOvVy4IAKcT+m7o+djuA0YgpYhjKjJTGHmprU=;
 b=qP/iIqHJcaYWF7Q0yiF2MBQDiseVfjNYu3RwJHM7N6MT02DpyxRA7iRAkm3DUq9XzbxSa8Peq+Vvx9g/bi4ymHlPvO6Qm9mYlkjP4DjfxUhqlBqtslLvrutRL3O189szcCEpekpUjZnGn7MEsTtnjyKdzE9o1Qv++uERgRrlpMA=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TY3PR01MB10470.jpnprd01.prod.outlook.com (2603:1096:400:312::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 08:00:23 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::7c12:d63c:a151:92bc]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::7c12:d63c:a151:92bc%9]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 08:00:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3CAADBRAIAAALaQgAELnoCAAAmiYIADcXiQgAAxe4CAACM10IACmYeAgAAAyzA=
Date:   Mon, 26 Sep 2022 08:00:23 +0000
Message-ID: <TYCPR01MB593348A5202E0E6619617AAF86529@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de>
 <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de>
 <OS0PR01MB5922B479EE78E840DA9B8F0E86509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdU_-Y_MV=6t+ri_MicEMK+Z5JhxHHp3AsDU+4KgdMsXSQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU_-Y_MV=6t+ri_MicEMK+Z5JhxHHp3AsDU+4KgdMsXSQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TY3PR01MB10470:EE_
x-ms-office365-filtering-correlation-id: 62e462ec-b5d6-485d-b7dd-08da9f952a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw6RI6QpRjo/gwYZjkm1rR0NmwhN/IzoKOD4mumNje/p10ZKvpSGDI32K6l/olYIwL9s6C5kelJcobnzIk6vbSsmPCCdQnmvJe9RqDYPyXRavy59BRJ6YgW4BWwZ9N+Afk8o23vp0NBTyHCJSW2PUfDX+HkTZ/B6YQe3IIrUNCiS1Sy4F/zW7bcUMQAIRcCzuT/1b3BTg+BWnC7sgsC8vOMGu/6aU81gLuHqVCzojeCUFmF+CSrg8J4rydY69oJUTx7RdtbSuSGBRiGrkArry2QegtdIsjyEKcLc+eF3D4bEoyuMRYwz+2KZS/C2nBiI1wZUjPeimDPoRLJxD3gx9Xg9tBpIH/odvu/YcVTkEbAuuTUoPllz56Jt3ibGIlTOrsJcJEVu5gN27QIKzc5SV0GTkeuhNqIT1q2OkXquNpC+JTygrYQBEw/zIQ/UCUAz63SaScf6+KDl/3t/7AUjcB2tylg04xhXglMTXu0x5JSlGo55Zs58i6ujNa4+Y4Byr82Q27t2W+/Vh86c8PQEVkNV+jYI+hSznpwiUnxYvNrzMHtREln8OwD3lUQe3SaVlLf086JZ2Or30tpMxq+fy5JW6vl4+sVlCLpTT6GZT0CYDaLkp9tli9XC6z5Mvaxp0efIY6OzXDsdUWFwCSm+3UEuKKLAFt6moCuZNLdUKCQ2vjXdXIcKjf45fUV6q2Yy6A2vWLVC0wrFvBmduFLuh9o0G+CNRcKuUZh1pksefm9uf+tTz3Qr01LfkXSgEFtgebn0SZxBNKk/3h/iswGCI2uf8O5zlX8f8pZ2TJ6mWlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(71200400001)(8676002)(83380400001)(186003)(86362001)(53546011)(55016003)(316002)(38100700002)(8936002)(26005)(9686003)(6506007)(966005)(5660300002)(478600001)(2906002)(38070700005)(52536014)(7696005)(66476007)(76116006)(66446008)(66556008)(64756008)(4326008)(66946007)(54906003)(6916009)(33656002)(122000001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a28yd2ZXcmF2NXJYSlJFb2gwQ0h0M01UR0R5SDlqaG54THA2NTlaNnYrT2Qv?=
 =?utf-8?B?ZUEvbEFqdW1aUG5BL21MNzNSYmplMFV4QU5jQUJiUXVDRjNyUEVjYVpKN2xt?=
 =?utf-8?B?ajB5d056ZXJCdVo1eDVoQ1lJdm9hSW5ocGd2a281c2pjZWFzZVhPa05NVHlv?=
 =?utf-8?B?SFI1WkFVYmt4NFdPR095VEtVbThuMWE3SWQ1TmRNTnREVzZCeWZaS0laNUVi?=
 =?utf-8?B?bWNyaXNRUEovM0NKeWVTRVZ0N3c4VXZ1M0hUL2Z4OUZxRjZmdkZhcWVvM2Np?=
 =?utf-8?B?dmJiU1hLL1JHZWNmbEVGK0FHVitNTXVYWHpCc2JRV2VTZ1BiQzJKVlkvZXBC?=
 =?utf-8?B?aUFsWXpKdmsxdS9PdjFISmMzeEJTUFJPSGlITWl2ZzVIcyt3TEc0c3VXeHY2?=
 =?utf-8?B?UDJOQkJUaS9rZDJUazBLaEhKMUJWdjlHRzZPTlRnYkMxR2J0ZUpLNG5VWGxi?=
 =?utf-8?B?c21aZHgwMkpPNzJpV1lPUGY2MVVDS3JTajQzeXIzaU51dHRvazA0TTJyUVRV?=
 =?utf-8?B?UDJMeFJ6V21QNjI3TTZjV2RhNWdsM2lGWmovaEhVdEt2TnVEcHJmTkR2NVBY?=
 =?utf-8?B?Y1BnWi90U2JTT0FkbmtiVjF1bjJIc0dyK2xOeWxVcjJNRFV2ci9weTZLbEF0?=
 =?utf-8?B?WWQyWXNQb2EvZWc1Q3VJaGY3MkJiSEt0WUN2OE1SOWI4OHJ2UnBpVXdwb1pq?=
 =?utf-8?B?dEExZncyWHZFQVNjRUFnNlJLQzJ3Y0JiY2ROUWVLcjRiWVhQUWwyT1BKZWRS?=
 =?utf-8?B?OVlEVFh3WFhZWUw4cG5aVDBtNGpSWldJT2h3SHZxUFczLzN1UXAzZ2pEZTg5?=
 =?utf-8?B?NFF6bHBBVVhNN21KOUJHMk9VSkppclNVanNVZkZSWTArMXdXR1FkV0d4UURE?=
 =?utf-8?B?SmpCVXFpM1pzRmZiamtDUnh2bzFQMWlSNGVBaDNkZVNYVTJZUlcwcGNaZnlQ?=
 =?utf-8?B?SnZrSS96ZEtndVRFMHhoOGt3cmRkNmFSMzA1YmR3ZCtFaWZRMDdFSlBsYzVJ?=
 =?utf-8?B?UVpuY0pudnN0RktiQlQwLzdTVkpmUlJ4Smp3VU9EdDFpczR0WmN2MkhqUHFa?=
 =?utf-8?B?WUU1RFQ5aGkxQkRMbXVBbFdIdnBJdjV4WXJXMjI5QVRCRjNRWHhQZWZ6NEZp?=
 =?utf-8?B?TnlLMWVSSGhudHZrUDZ2Y0RHb1M0dVIzeVpBaDBnWmRLVHQxajFoNWtGVGw4?=
 =?utf-8?B?OFdxVHgwcStLTHZXOWRRbitreCtUTnYxSThUcUZLU1dxUzZjVU5sR3VVMkZa?=
 =?utf-8?B?ZnIxWUVxR0o4UXREeHVFVHhucTllZHJUbU5RMWR6S2FvR1JNbjFjY2lOU2Vm?=
 =?utf-8?B?REJnKzlEV3NrU3NJUFI5RWhCb1FzRTdPUVhrT2I1UklhU2k5Snlma2tMVUJT?=
 =?utf-8?B?RytiL1BHczYzd0JPMXorZlNRREZJYXArRi84WEd6M0QyMUxrSGtzZFR5c1E5?=
 =?utf-8?B?aUQ4UEt1NEp4SGhjMk1sVVVITU1ab0VSUGEwOVcwcUtyc2g0ZXdjNmFqU0dP?=
 =?utf-8?B?MUdvTVdldDRTLzlXdXZiOXIreUV0M2xIM3RIQzR4Z3g1Zy9uUmg2ek5yWlVJ?=
 =?utf-8?B?MU9KYk0wOXhKZFFCbjF0c2R1L0ltQjdORnVEbG94V2N2dGFxSmc5MHhiVkNZ?=
 =?utf-8?B?Vi9QcFFSYWFLaGg5YU50SFpIY2VoRFloWC9MR1dKWUNCcHVHeGR4V2w0WTUz?=
 =?utf-8?B?RmVudDgraUhERnAzdTBKU1RCekllNzNzSk92V0ppK0FCdUR2TGg4NklrWmNP?=
 =?utf-8?B?UTRBVXoweC9tWUx0TE4yWWxFQVQ2WWdJeGV4VDZ1SXFpemZaTVdtTkIxRzNB?=
 =?utf-8?B?UStYcGQydTRYdk5tOXRqRTBRbXY2YTdlSHJFM09YSXBDbkpERmdTOE9wbHUv?=
 =?utf-8?B?SDBQY2hoVWszT3N5OTVFMHg1R0J2RUZrSGszeldyNzVlNXBWendJdlJnQkJi?=
 =?utf-8?B?WHJ1dUNIUXkxOHVlUEFOV2d5MFc0TCtFV0NkeDMwRWRpQjUrL3VlTUYrWWMw?=
 =?utf-8?B?aVF4NnJxZDBIYTVGak11eG44Nld3N3dMQ1BCWUVzemVMWEFMRjdIcEEyOHZV?=
 =?utf-8?B?UCsza2RFaXZDcmtnNmVlRnBMNnpUQ1JSSjdhQ3FBYm13dkdvOUlvNVo2NTVU?=
 =?utf-8?Q?8zNqPXHbP+50LNFSuq5de+Ode?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e462ec-b5d6-485d-b7dd-08da9f952a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 08:00:23.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCHCqeUceMsRLe7hhQGD939LJbohHmgIwCf3lXyAfyK7tCCqjvLQL/KWHKzszRQP03sBwWR5OO2wT0xoIcvACIsydrCRyoUOGRjd819xyz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10470
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjYgMi8yXSBwd206IEFkZCBzdXBwb3J0IGZvciBSWi9HMkwgR1BUDQo+IA0KPiBIaSBC
aWp1LA0KPiANCj4gT24gU2F0LCBTZXAgMjQsIDIwMjIgYXQgNjoxMCBQTSBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IE5vdGU6DQo+ID4gSSBoYXZl
IGEgcGxhbiB0byBkZXZlbG9wIGFub3RoZXIgUFdNIGRyaXZlciB1c2luZyBNVFUgSVAgb24gdGhl
IHNhbWUNCj4gU29DLg0KPiA+IFRoZSB3b3JrIGlzIG5vdCBzdGFydGVkIHlldC4NCj4gDQo+IFRo
YXQgaXMgdGhlIE1UVTMsIHdoaWNoIHNlZW1zIHRvIGJlIGEgZnVydGhlciBldm9sdXRpb24gb2Yg
dGhlIE1UVTIgaW4NCj4gZS5nLiBSWi9BMSwgd2hpY2ggaXMgYWxyZWFkeSBzdXBwb3J0ZWQgYXMg
YSB0aW1lciB0aHJvdWdoIHRoZQ0KPiBzaF9tdHUyIGRyaXZlcj8NCg0Kc2hfbXR1MiBpcyBqdXN0
IHN1cHBvcnRzIGNsb2NrIGV2ZW50cy4gTVRVMiBpcyBtdWNoIHBvd2VyZnVsIGFuZCB3ZSBhcmUN
Cm5vdCBzdXBwb3J0aW5nIG1vcmUgYWR2YW5jZWQgZmVhdHVyZXMgbGlrZSBwaGFzZSBjb3VudGlu
Zyhjb3VudGVyIGZyYW1ld29yayksDQpQV00oZnJhbWUgd29rKSBldGMuLi4NCg0KPiANCj4gPiBG
b3IgdGhpcyBJUCwgSSBwbGFubmVkIHRvIHVzZSBNRkQgZnJhbWV3b3JrIGZvciB0aGUgTVRVIGRy
aXZlciBhbmQNCj4gPiBXaWxsIGFkZCBjb3VudGVyIGRyaXZlciwgdGltZXIgZHJpdmVyKGNsb2Nr
IHNvdXJjZSwgY2xvY2sgZXZlbnQpIGFuZA0KPiA+IHB3bSBkcml2ZXIgYXMgY2hpbGQgZGV2aWNl
cy4NCj4gPg0KPiA+IEN1cnJlbnRseSB0aGUgTUZEIGRyaXZlciBhbmQgMTYtQml0IFBoYXNlIENv
dW50aW5nIHVzaW5nIGNvdW50ZXINCj4gPiBmcmFtZXdvcmsgaXMgYWxtb3N0IGRvbmUuDQo+IA0K
PiBEbyB5b3UgcmVhbGx5IG5lZWQgYW4gTUZEPyAoTUZEcyB0cmlnZ2VyIGEgcmVkIGZsYWcgZm9y
IG1lIDstKSBFLmcuDQoNClNpbWlsYXIgY29uY2VwdCBpcyBhbHJlYWR5IGF2YWlsYWJsZSBpbiBt
YWlubGluZVsxXS4NClNlZSBTVE0zMiB0aW1lcnMgd2hlcmUgdGhlcmUgaXMgYW4gTUZEIGRyaXZl
ciBzdXBwb3J0cyB0aW1lciwgY291bnRlcg0KQW5kIHB3bSBhcyBjaGlsZCBkZXZpY2VzLg0KDQpb
MV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzUvQy9pZGVudC9USU1f
QVJSDQoNCj4gdGhlcmUgYXJlIHR3byBzZXRzIG9mIGJpbmRpbmdzIGZvciByZW5lc2FzLHRwdTog
d2hlbiAjcHdtLWNlbGxzIGlzDQo+IHByZXNlbnQsIGl0IGlzIHVzZWQgZm9yIFBXTSwgb3RoZXJ3
aXNlIGl0IGlzIHVzZWQgYXMgYSB0aW1lci4NCg0KWzJdDQpZZXMsIHdlIGNvdWxkIGVuY2Fwc3Vs
YXRlIGFsbCBpbiBQV00uIEJ1dCB0aGVuIHdlIG5lZWQgdG8gY2FsbA0KT3RoZXIgc3VzYnN5dGVt
IGZyb20gcHdtIChlZzotIGNvdW50ZXIgYW5kIHRpbWVyKS4NCg0KSSBhbSBub3Qgc3VyZSwgUFdN
IHN1YnN5c3RlbSBwZW9wbGUgYWxsb3dzIHRvIGNhbGwgY291bnRlciBhbmQNClRpbWVyIHN1YnN5
c3RlbSBjYWxscyBmcm9tIHB3bSBkcml2ZXI/PyBJZiB5ZXMsIHRoZW4gdGhhdCB3aWxsIHNpbXBs
aWZpZXMgYSBsb3QuDQoNClszXQ0KSSBhbG1vc3QgaGF2ZSBhbiBSRkMgcmVhZHkgZm9yIE1GRCAr
IDE2LWJpdCBwaGFzZSBjb3VudGluZyBtb2RlDQpVc2luZyBjb3VudGVyIGRldmljZSB3aXRoIE1U
VTMgd2hpY2ggaXMgdGVzdGVkIG9uIE1UVXsxLDJ9IGNoYW5uZWxzLg0KDQpTbyBiYXNpY2FsbHks
IHdlIG5lZWQgdG8gZGVjaWRlIHdoZXRoZXIgdG8gZ28gd2l0aCBhcHByb2FjaCBbMl0NCk9yIFsz
XT8/DQoNClBsZWFzZSBzaGFyZSB5b3VyIHZpZXdzLCBJIGNhbiBwb3N0IFJGQyBwYXRjaCB0byBn
ZXQgYSBjbGVhciBwaWN0dXJlDQppZiBuZWVkZWQuIFBsZWFzZSBsZXQgbWUga25vdy4NCg0KQ2hl
ZXJzLA0KQmlqdQ0KDQo=
