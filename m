Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12185F2C27
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJCImA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Oct 2022 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJCIll (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2022 04:41:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2096.outbound.protection.outlook.com [40.107.113.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB908101F4;
        Mon,  3 Oct 2022 01:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6KvtLupvNFMOn6KJJSEwhs3tjSpFo3wQw5Dh/ujRE4vguvBcR7onbZl1+UaQe5k8+rDS8qaBFOqXT2Sy5dPnJp2p9WgxroTv6tS9d2J1gga/11klNb5KALi4Ve4GchM4kTbyqVipKF+nsOknrxPaZFMaF2phmVTP2kAXL2oW7yEHqUb43mrez4yxA9eCEUHDfGaZG0HWGe7EiQnivkhC+gOSE8NJK33WwZmCAiqLMHv9OHT3l+6js9S2OR9Kj6nE+NWUFOzJkNyCpgyoUzEaUewS4xO2wneZ3STAieqoCzyPPX1XVeXtJEVfKqqcIvQah9MaZUYeQPUCYhx+0J4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWyCnCDO08fAtepivoo/r1HnhPRm4WdfvibHlH8GILY=;
 b=fugqPL3FeQSsrkJEe7mkjILSsxTxfQtc0PClmjsOd7LMJ8k8TYXXLPe41R4fppFA1C3RfeqYFJEbEmlbH/WAw7FRTQJ67KMAguoP5bAioZWq31FjVZ5MEIYh35/BrQJVkXaEbLQL7EFJySlAh44k3QJAbQ33g9ZLPMcwod47Kq2XPtd8W4uD27XXCtMxfOXD/tiGvnQdsXnRMipjyS7ec2smTNkf/TGg2bwe+HA4+ZVBOrFUSLY2CEqRogenSKinuHuXPkPl6d3XxQTgDasjU6KUjL+bmaYTDKFCkvDLsMCwjQ8wXUgYLPqKjs19HiKbKkdAYWuGuamnjnldiLm5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWyCnCDO08fAtepivoo/r1HnhPRm4WdfvibHlH8GILY=;
 b=Gq7vbwsuhnfbom5C+Li1Yi3L/suv/m0uu5AXPNyoiDo3WFPDzw4/KJJ4q7K6IvFkKRxTXqnb/JIceqWHJVpjpVEKa0bwRSfULMSJldNcrG+7+7OoXhmC5JY+Sg1JcYx1KuH+ot6m3zCFB63hy6ai74C5ZxXqs+vYoenWgCcsaSQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB10802.jpnprd01.prod.outlook.com (2603:1096:400:324::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 08:16:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 08:16:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Topic: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq32sJKAgAABH3CAATHPgIACC6NggAJdkoCAAAsx0A==
Date:   Mon, 3 Oct 2022 08:16:34 +0000
Message-ID: <OS0PR01MB5922630991BABA41FAE06BBE865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
 <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzqQC3gEzGksqYzk@google.com>
In-Reply-To: <YzqQC3gEzGksqYzk@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY1PR01MB10802:EE_
x-ms-office365-filtering-correlation-id: c61f9f13-8fef-4652-32bb-08daa5179611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9dBdu5Rsmxf7S5YnZWAaQfmtcwnufe14BHfTMxa+s9rUY8o1TpvdYkyeF88yMH+Zc4d9cMtUMpaoJMFhyIgyGJ+uDWNidn2zcwqysF+/a+/3ysc5ch0t4rHmQaFWLGYENwO/IzJL0N0tZev6SijIW29/J2y0uh2o3SKIeuV8eK4yL/+ixzYJdTseJm7L+qnA7PsFQq1aiYWIGVmSZgFMZYBmQc8m+NSiGeiUH1ioQNpxM7ikabQ3TrLArJkn99GGWs6+z4mBekerxlhOX3P0CP3EMEKlmO9R+iSpg8pKv8wosWqyirKP8G31yIaN501NgNdmWBjmU8kBEEaBKXjQE24ZEpjRX80mzyqAI5092qS3nVzGhMSLh4QVBI4YLjF3CBPsDY4BtG3DDV4ahP2kHXs/LpEgs2P7GJyEiOrio+KQ/Nc7mDY8SiNzDuc6a2w6pK+WGW48X03kh2Ipwjeam++Mdt+CsqewpWPQONow6sQC5sQpQf+rMc3ekoKRSorAnSwBIvMX7kW1u7/i+9fdZIUgHgOHxgpKBTpPHMPA31aaf82oDWPucz8koh1qQkxvSklScjDZ60x+PVhisaTkHyX4y3ki2R8w7nH1YkWFrhcwWfn7A8LLb62oDQd7iJn0ZtfW9zNjOs47PFBwo12ZcmCS9wMnwxOL55dDUunb7OxspmFZ2Mi7nsjDL+eaiK4wLNnNDFGeg4DFjtOqD9omrbopTUY/u7VAArmoNvXPTcb0m5qTYR3d2VoE4cM5gcPb67y6RCJHFNG8Fnd0+Zfjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(38070700005)(122000001)(316002)(64756008)(66446008)(66476007)(66946007)(4326008)(76116006)(8676002)(478600001)(55016003)(66556008)(38100700002)(186003)(7696005)(6506007)(33656002)(9686003)(54906003)(26005)(6916009)(71200400001)(86362001)(8936002)(52536014)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhzMlhUVW82cFQvaERCVVZtNmczeU41SDQ0N3A3cStydHV6NWtHbHo3T3VR?=
 =?utf-8?B?LzhteDhHdFhrUllFVFpaRk9xVkpFUnJKWVF6eWhHK0NqTUg0RzFJVkNZVXNx?=
 =?utf-8?B?NlFQUDZUdWJYdFliU1I3MmJDbzNpRmpjTlgrRWN3amJ3eDAyeDlLNWNoZXhG?=
 =?utf-8?B?VGV2eVZLWUd4ZGdaVldGODdTNFFEUWYxV3RwaUY2QklEVVBEZHlONmZrM0Jr?=
 =?utf-8?B?azUyd2lkNWVzam9hUWVoU2h0M2ZLemptRzJlTklpZldQVCtodTB0cG93cjM5?=
 =?utf-8?B?aGtCS0FPZkJIWUZQSWNDb2dLMUVDek14T0JuNkFzNEgxbmdmV0M3SGJGZStl?=
 =?utf-8?B?bXRSaklGOWM4Zzh2SXdvRmtmYjZ4eWhObXJZTGRoYnNHM3ltYzIxNTJxRVFv?=
 =?utf-8?B?TVJremhBS1BCTVZUbEc1alZzNHE1WnlDVnZVZStVbFBKRGN0OGREZ2tKUlNt?=
 =?utf-8?B?MXNaQitDZnRFNFlQSm9oaFlWUERDOVFQUWNDUG04WkF6YzNJdXZLZHF3Zjlk?=
 =?utf-8?B?OFpZYjRaOFpONUFubkZiYVpJcHN5ZGpkY2FmVHlLM3NNWlJLVDB1Y0JldWZ5?=
 =?utf-8?B?RFE0TS9majBjWWVRK05NYm8rZHRtN01CTVN5QzQ4WGcwVEJLaG92WTAvQjVK?=
 =?utf-8?B?Q3BTcHdhNVJBUzdmZ0hQRVFFYjRFNUhhb2E0amd2ZkhySTgyNVBrUXFTenht?=
 =?utf-8?B?cFRXQVZUM2FtSUFtTzNtdTByR3k5NjhBb21YaC94RUhXS3ViNURmY2hMTnFj?=
 =?utf-8?B?OFprbk1DMDFvNFVBUUUraSttUUh4TnRrRzFtVlVHaTJBN0UyZWtvMlhWblZN?=
 =?utf-8?B?WHlmYmliOTZZWHBXTVBMbGh6OERyTndGL21nZ2JHeHVFUG5scHlEVHJiNmEy?=
 =?utf-8?B?UFF6TkpGdE5UYjRyMnlDQ0ROYzdrU0pOSnVqWHhRdTg5UnR4UzJZSktxekRs?=
 =?utf-8?B?L25Nc0E3MlVQN1JIMmI4V3NiNGZocExIblJsS01haDJlczV4WFNzMGJLM1BD?=
 =?utf-8?B?VzlhV3dMbVhSLzdJdFVDaDBjMUk3eFFHbHhGYlZJSmJVVVdIWEYrTDQrSnJz?=
 =?utf-8?B?V2FGTWdJSFU1SGZ6anplSTVhRktBOXhXdTJpaGJTWTB1Mmh1RGlrYmoxT0o3?=
 =?utf-8?B?bEhCZmpMNUlCQml3U2pzKzVUVnNHNHgrSnorQ2UvblpWQnM3eTVuRXIyYkVh?=
 =?utf-8?B?aHVlNjF6UWxYQjVUcEdGdVFSOVkxSzZZZUQ1Q2FFSnptMjArdHJBbm9uMnRy?=
 =?utf-8?B?cm9pNk5QQ1l6dWxIZFN0MWQ0SVMxVWJZZEdNeHhyYVhKRFR1bUtOR00wRFZO?=
 =?utf-8?B?YVJ5bVRDYmNKbVNrNmQzUG1VTzVENndwK0NUNWx6MWtMRzF1Y3QwNmo2cGQ3?=
 =?utf-8?B?REpweGZMejcrQVBrZ3JacHp1MUZ4K3JtOFhGbjl4REx6L2dIU0hJNjNQeXk5?=
 =?utf-8?B?NzZyV0oyYThCR2F4eVJWQkZWaldYNHNrYkZkSXF3bkpjV0hFTXk3cGs2bTRl?=
 =?utf-8?B?aFFCbUVWdGVGQ3BZbzZNeXBuUFYyMXdFa1prd3g0OFR0bSt1ckNIaUlXT1VK?=
 =?utf-8?B?YXk4d3lUTlptU251Q3ArNFhseUF4bGt2WUZwM3k2NTNXZjE5UUdtcXFxeUNw?=
 =?utf-8?B?bVhuMHo4VldGSnM2S1UyL1ZmS0xjVjM1YW5tQ1BURzFCcXliZS9ieE8rSjcw?=
 =?utf-8?B?QkN0dG9HU1JTT0JJRzJiMGZ3Vk4vYXBiZXFJbDltU2Z5QVhoRUFjdlg0NkhG?=
 =?utf-8?B?b2p1dWZhR01NMmYya2w1QnUrVHo0NHNaMkdYbEJ5ajR2clhtaUg4MWNDbTRo?=
 =?utf-8?B?NndRSCszMFZVdmpQUEZQNnZTRDBqZDJwNEFCYXFBTm8xWFRWUDJ1RGZaZkRP?=
 =?utf-8?B?MzdRazdmMkt6WUg2L1AvKy9pZlQ3NHVmVEVMVUY5KzNRWmV4Wld6YjBXeFNP?=
 =?utf-8?B?bDJoZmEreUg3QWtnQXlNSVpyM1JmOXVPU2o4UXN2SE5RZzRWemhseUNmTENO?=
 =?utf-8?B?VXJKdUZCYzBaeE5YNFdtTUxUMFJkZGY4TVVrVUV4QmxiZUZyWU9MZkFQSFhU?=
 =?utf-8?B?dUhEcFo2MWV0eGRxWGdhTy9yTTlqdXF1cGpMd0J5b2hobzY4aXoxWlRrYW8y?=
 =?utf-8?Q?Ft/Ik3hf7FAfcV68B4XIWj3QR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f9f13-8fef-4652-32bb-08daa5179611
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 08:16:34.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scWVcmv817nZZz1YXOS8gXaS0n48rVNRQVJSdkyHC/HvteBnas+TjEv2pEY1ML8i+SNajCZqVfnFPkOtK1gKkbPdHk231zFP3EMdCqKo3AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10802
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDMvN10gZHQtYmluZGluZ3M6IG1m
ZDogcnotbXR1MzogRG9jdW1lbnQNCj4gUlovRzJMIE1UVTMgUFdNDQo+IA0KPiBPbiBTYXQsIDAx
IE9jdCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4gSGkgTGVlIEpvbmVzLA0KPiA+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBtZmQ6IHJ6LW10
dTM6IERvY3VtZW50DQo+ID4gPiBSWi9HMkwgTVRVMyBQV00NCj4gPiA+DQo+ID4gPiBPbiBUaHUs
IDI5IFNlcCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEhpIExlZSBKb25l
cywNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4gPiA+DQo+
ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgMy83XSBkdC1iaW5kaW5nczogbWZkOiBy
ei1tdHUzOg0KPiBEb2N1bWVudA0KPiA+ID4gPiA+IFJaL0cyTCBNVFUzIFBXTQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gT24gVGh1LCAyOSBTZXAgMjAyMiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IERvY3VtZW50IFJaL0cyTCBNVFUzIFBXTSBzdXBwb3J0LiBJdCBzdXBw
b3J0cyBmb2xsb3dpbmcgcHdtDQo+ID4gPiBtb2Rlcy4NCj4gPiA+ID4gPiA+IAkxKSBQV00gbW9k
ZSAxDQo+ID4gPiA+ID4gPiAJMikgUFdNIG1vZGUgMg0KPiA+ID4gPiA+ID4gCTMpIFJlc2V0LXN5
bmNocm9uaXplZCBQV00gbW9kZQ0KPiA+ID4gPiA+ID4gCTQpIENvbXBsZW1lbnRhcnkgUFdNIG1v
ZGUgMSAodHJhbnNmZXIgYXQgY3Jlc3QpDQo+ID4gPiA+ID4gPiAJNSkgQ29tcGxlbWVudGFyeSBQ
V00gbW9kZSAyICh0cmFuc2ZlciBhdCB0cm91Z2gpDQo+ID4gPiA+ID4gPiAJNikgQ29tcGxlbWVu
dGFyeSBQV00gbW9kZSAzICh0cmFuc2ZlciBhdCBjcmVzdCBhbmQgdHJvdWdoKQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gU2hvdWxkbid0IGFsbCB0aGlzIGdvIGluIHRoZSBQV00gZHJpdmVyIGJpbmRp
bmc/DQo+ID4gPiA+DQo+ID4gPiA+IExvb2tzIGxpa2UgYXQgdG9wIGxldmVsIE1UVTMgSVAgcHJv
dmlkZXMgc2ltaWxhciBIVw0KPiBmdW5jdGlvbmFsaXR5DQo+ID4gPiBsaWtlDQo+ID4gPiA+IGJl
bG93IGJpbmRpbmcgWzFdLCB3aGVyZSB0aGVyZSBpcyBhIGNvcmUgTUZEIGRyaXZlciBhbmQgcHdt
LA0KPiA+ID4gPiBjb3VudGVyIGFuZCB0aW1lciBhcyBjaGlsZCBkZXZpY2VzLg0KPiA+ID4NCj4g
PiA+IFByZXZpb3VzIG1pc3Rha2VzIGFyZSBub3QgZ29vZCByZWZlcmVuY2VzIGZvciB3aGF0IHNo
b3VsZCBoYXBwZW4NCj4gaW4NCj4gPiA+IHRoZSBwcmVzZW50IGFuZCB0aGUgZnV0dXJlLiA9OykN
Cj4gPg0KPiA+IFdoeSBkbyB5b3UgdGhpbmsgdGhhdCByZWZlcmVuY2UgaXMgbm90IGEgZ29vZCBv
bmU/IEkgYmVsaWV2ZSB0aGVyZQ0KPiA+IHNob3VsZCBiZSBzb21lIHJlYXNvbiBmb3IgaXQuDQo+
IA0KPiBJIGRpZG4ndCBldmVuIGxvb2sgYXQgaXQuDQo+IA0KPiBXaGF0IEkgImJlbGlldmUiIGlz
IHRoYXQgZG9jdW1lbnRhdGlvbiBmb3IgZWFjaCBmdW5jdGlvbmFsaXR5DQo+IGJlbG9uZ2luZyB0
byBhIHBhcnRpY3VsYXIgc3Vic3lzdGVtIHNob3VsZCBsaXZlIGluIHN1YnN5c3RlbSdzDQo+IGFz
c29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBkaXJlY3RvcnkgYW5kIGJlIHJldmlld2VkL21haW50YWlu
ZWQgYnkgdGhhdA0KPiBzdWJzeXN0ZW0ncyBhc3NvY2lhdGVkIG1haW50YWluZXIuDQoNCklmIEkg
YW0gY29ycmVjdCwgTUZEIGlzIHN1YnN5c3RlbSBmb3IgY2FsbGluZyBzaGFyZWQgcmVzb3VyY2Vz
DQphY3Jvc3Mgc3Vic3lzdGVtcy4NCg0KSGVyZSBzaGFyZWQgcmVzb3VyY2VzIGFyZSBjaGFubmVs
cyB3aGljaCBpcyBzaGFyZWQgYnkgdGltZXIsIGNvdW50ZXIgYW5kIHB3bQ0KDQpUaGV5IGFyZSBj
aGlsZCBvYmplY3RzIG9mIE1GRCBzdWJzeXN0ZW1zLiBUaGF0IGlzIHRoZSByZWFzb24gaXQgaXMg
aW4gTUZEbmRpbmdzLg0KDQpDaGVlcnMsDQpCaWp1DQo=
