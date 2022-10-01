Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4068F5F1EAD
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJASvy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJASvx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 14:51:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24029C8A;
        Sat,  1 Oct 2022 11:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmQV3B0Lz3XA90HJZWxmseb2SiTrHEVUIs5xRpV8m0oLmkSxDBr2QR6DGKJrRyd0xBJGd8RqFr4VREek4zdHMRGrdJNaIonaPnGb3qnLaWuCMlkpAy/Y3d0a6XxtkH93zgthPZvk7fOb7Wcr+czjIRbiLH341JftkopdqJyXAiOB7K5XTihdOHo6WwRkPRaLMXEn8C3YNqNl6dxGe4reADkXnisz0u8pIT73FXiJzVIM1HNELJR06VcBAzrRToMQ4KcpxrmZgQrPa5K+iATW0zQsyA7bcXXe/sDAo3yN8QSh1zhyEnI4GY/qo5/4kVHZ/xK6qzTVkCCVBrxVVMjsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nyN9d6nrTTm0cS6tlr7Asps3Yh3H3Q9cXPNjYabRuE=;
 b=R/XVBbsK4N9cicZT3V1mVROxsrV814FEY9uZQayHpNg+JjNbb+EKyvhhK2AZ9wzGi52Ikcsu77+Xv291gmB6ch3MfTIb3wOUtuxvB3TY/B2CS8u13fCEL6RVbEXx1oLBdg1XsIzMWHoIkdPdXDLuXlzB2Eft4dmIEpZjfwLG7bC5R4o2O61K5P0w7qjO88UzetquzR242YXMLQoeUlSX1Kb6j4sl/OGMbrZna/c5J1sD2gS7EoC8nr8R+FUJl/NbnJHe4ARIiLPoY9qTON/9+Mc92Ksl239Z7LU7ouSi9Z4KHmVYfG7JKEMVj87tMJIkq9eMWpxFqB0sGvZwIuK0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nyN9d6nrTTm0cS6tlr7Asps3Yh3H3Q9cXPNjYabRuE=;
 b=SnPNpNXuDQCvDFwz8lcUfwOpwrVWDS6KbVwk+98MLzA8SJcFeeR6VvKClQ0t2RzpX9xV1qLfVTdN3wHpVnyFPqTHkuP4yH/tP+pNbpDlpKYeIB+ssS0dMCNNi8Jph2h+RxM6+F0F7niNIHhfI+361y1r7Du6HSYyA/Xr9FM1m/8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8307.jpnprd01.prod.outlook.com (2603:1096:604:182::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 18:51:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 18:51:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     William Breathitt Gray <wbg@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Topic: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoCABD8nAIABKKwQgAAHVwCAAAESkIAACY4AgAABz8CAAAyBgIAAAxKw
Date:   Sat, 1 Oct 2022 18:51:48 +0000
Message-ID: <OS0PR01MB5922F041D9C6EB2EBB9F8C8C86599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzh8ULruBgN1tf+L@fedora>
 <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YziIUV3tyPd0GrFf@fedora>
In-Reply-To: <YziIUV3tyPd0GrFf@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8307:EE_
x-ms-office365-filtering-correlation-id: 9923d36c-9d9a-49f4-e82d-08daa3ddff02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhXMkpdtNGFw4VKUduFRuPq3EA7CYgqRRrXstG8H/tM0/lBv8opm//mDJSrj/zwR1WmEwtbBETzEG60NT0j71NlaSw5b/l16BnDWjNZSsJNAOjZZUZ57Zycwe0+kckGVUJS5m3sulrVemmm2quUFf5hyyFel1gm+PV0zFRrgv5h366+YxQsLMSOdWCccbcm4jvBbG8RZMYumjscxiB2lGNO8bke7lue4zOASHyPUij6ZV8TPOj6kZAOb7483HBDmMSFFTepAc6Dn4DVA3BeUqgBM84ljjySKi+KRqv9Joma/d1E9YAFaMdwQOG3VFcamZNWIxnTnVpRxJTKuqrqTu/t/vU+q5/HooPjAJNWslzDfs5mNkb1UrGVnTTc8im6byKdFO7Gm12XBzAw9NNp7joSNRPFGp2Ln9Bb7UR4ZaYkwf54pX7XnlpUCbX276y+fEnprswMM04xTIP/wncAKrwNmLbeU2OTInnSZ5qMpigbo1sE/yun9msDhMEjX2jeGh/MPyGE8a2pTcEHUGyW6t5uKO/vXF5ufkuOEsKtZ1xaqBEkFdXtq9zDugC2ygOeRV18CkHp4I06cCMH8j2bJVwmRTcbVqfCXp3+9Rg9RQV2yWqW3bcKDNkWrgsHJ+Gf20+kbkDpNQESJm64Q/IeipHYbVPfYALO1JdtaQrmwJ65hwyLRuQi10N5WG5UNnUsxTEvQJxC+ILK89sc0TrnbLFdr5ETpo7jTFV+uyRaatkFVZEwhRHlWofN15h8Ehih15XIuKzMby9ZBwVHigSZCVYYwvWXsbstNqgPLLtbk2e8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(38070700005)(86362001)(26005)(66946007)(66556008)(33656002)(66476007)(66446008)(64756008)(8676002)(4326008)(76116006)(2906002)(83380400001)(186003)(41300700001)(71200400001)(55016003)(478600001)(38100700002)(122000001)(316002)(54906003)(6916009)(9686003)(7696005)(6506007)(5660300002)(7416002)(8936002)(52536014)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JVRj6o3GiaqmcRpnIppfe2iCtHX90GC2F/lnYJHLgwR9HhdizdM/noYmgy?=
 =?iso-8859-1?Q?WnrnP5nxql3YrEgF6CuKum0Prf8mqHxMVTg/4QQC9x72op9hqMoDwkAdmk?=
 =?iso-8859-1?Q?zje+AOFRqGbxVCHq/hccVIgFuXZlpR3bRb7oLsezzfKFv1e8N7trlGyiEt?=
 =?iso-8859-1?Q?DmwcKic61rl6HoF6sIFlMbLuPbUOXObUBtjH6Mo3M/KO5+TtNb7h3YBHkc?=
 =?iso-8859-1?Q?9svBprfeTp0i94D9AdjUyMkOYLjsZ+d6IEcbRGlkCparHKrnsJZY6F3Jpz?=
 =?iso-8859-1?Q?H4XaXzf0qR0SVBr86IN1fv5VjY4tQkyA3YecszhVRwOs3nOwwnsEoWYF5M?=
 =?iso-8859-1?Q?2tWkzf7FavenQmA0uQl0AInTphrhnS3TxVHh5fdPGWpLJ9L65InHWeunAN?=
 =?iso-8859-1?Q?DaaRG4mqoc4tgoeqdH3wyOOKP9scuuHI8lSh3KM3tIj+GmNVpp6MTKyLEq?=
 =?iso-8859-1?Q?MW20u7HbXPnw1XQ9jg+0DjG6SnMbgZBYRKkHOTJ2RMZvW5NF2ITjfjC9em?=
 =?iso-8859-1?Q?xH5SpkNhYJ1pILzv6q0pbSBZ5M0lW31iymqIT7pLFJC07im9Eb9qXac7F/?=
 =?iso-8859-1?Q?lDqD++9u0b0l7CgfcjJh1yxIw3eNFSGsJMcVVkTYVAov0ZHrWDwvEYDlYE?=
 =?iso-8859-1?Q?si0cwLpCklWsSZoebE03u/GKRHceDY9J3KSiQ4MmJVw/0Zg/oCJC4cS69b?=
 =?iso-8859-1?Q?AvYwkEhlm1eVy1THMLBSC/NRQ9Wr0UMDgvcw6C0g0jtARcW6IdUv08Ckib?=
 =?iso-8859-1?Q?oD41u9wviK2YX9zQkKxo1nI94vKb49Jesf/yljorB4Gogkzf+soDqgYxX0?=
 =?iso-8859-1?Q?6IkemrYwqvxrLB23vbpu4kuukHG33rZwXvm/DJO9lZ9Ui/UXzJ+vZsg+f3?=
 =?iso-8859-1?Q?mXrAOQkADkQuSQTJIH5TQhqpD0Ju0+h/8HrGNOzgssBa07NBS/i7Ze94Oe?=
 =?iso-8859-1?Q?3q9QeMORyJ2R6SbP7hmQj/L0iTLKTJOwvBS/cRIl3KwACeBTBxwL4cGRoD?=
 =?iso-8859-1?Q?x3ubpA8DXBhmNVY+Ew0uMh9VZ5eKvIj4lKswSOPRuByS/A5QlQP4qdjx5t?=
 =?iso-8859-1?Q?H5DDGqNJGcRGZCf8XtAWwRyPzB07FfiTQARjaaJLv77nehkmQ59O2kKXTU?=
 =?iso-8859-1?Q?nIZPGq52JucgcLXYz+uL/r1pHzOXLz91ss07bmvgwGQblZ2W4OG5kVqR2d?=
 =?iso-8859-1?Q?tXqu+b4EElT2k/lyCl9uJIgJTz5rLbqIAVv60kOkygD5nF/0c5+TF+AG2k?=
 =?iso-8859-1?Q?U5s4e1BAQPNNWieWpIuNwBcJiZ0KOOxIW6+WKxPP/4QZ4th08I7gR7PpsV?=
 =?iso-8859-1?Q?EYxMOjuCS6cU0OUXROWHWcNLKS5JVevm6V91CtvRI5ZweL63P1VFdyDiAe?=
 =?iso-8859-1?Q?aUBkxwct3YwJJJrBUfpPMhutwpO95aIgXrxCqXLJI/NickgO6c+RgI4LWw?=
 =?iso-8859-1?Q?Cj7Flzny84X51IlEZKJ0H1AkPFtyqP0OZIKcrEEydRKKXbw7aoTRg43Frw?=
 =?iso-8859-1?Q?lCmDR2VT2OXc/r9LgQKA3AKmt0kiuZlmKfa49TgQoD3QDHrNTgNznlBKNz?=
 =?iso-8859-1?Q?GBSmNu4WcRR2m5hANnuzIvZIWK4lFvuL1LV39wk9iSuEsf/6Gs4Qsyq5uD?=
 =?iso-8859-1?Q?z4kV9HlAdgDQk1nZbaM1KPb4waFUp0yOry?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9923d36c-9d9a-49f4-e82d-08daa3ddff02
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 18:51:48.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bc/FL0d/ELWMGXOrQK5x9EssG/BygHAJmvM3VVF86VD3r9pO/vvh893KqC+rCaFbYI+C2i7BSuPUHybyKHlGjp1G/ayE+fjrVS+T1NA6Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8307
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Sat, Oct 01, 2022 at 06:03:37PM +0000, Biju Das wrote:
> > > What is the configuration when 32-bit phase counting mode is
> selected?
> >
> > LWA Bit (MTU1/MTU2 Combination Longword Access Control) needs to set
> for 32-bit phase counting mode.
> >
> > b0 LWA 0 R/W MTU1/MTU2 Combination Longword Access Control
> > 0: 16-bit access is enabled.
> > 1: 32-bit access is enabled.
> >
> > > Does MTCLKA and MTCLKB serve as the counting signals in this case,
> >
> > For 16-bit and 32-bit counting signals same. We can set
> >
> > 1) MTU 1 and MTU2 signals as MTCLKA and MTCLKB
> >
> > Or
> >
> > 2) MTU 1 signal as MTCLKA and MTCLKB and MTU2 signals as MTCLKC and
> > MTCLKD
>=20
> I'm having trouble understanding this case. If 32-bit access is
> enabled by setting the LWA bit, and the MTU1 signals are configured as
> MTCLKA and MTCLKB while at the same time the MTU2 signals are
> configured as MTCLKC and MTCLKD, how is the 32-bit count value
> determined -- wouldn't
> MTU1 and MTU2 be counting independently if they each had separate
> input clocks fed to them?

It is taken care by the HW. We just configure the register as mentioned bel=
ow
and hardware provide counter values once feeding the signals to=20
either
{MTCLKA and MTCLKB} for both MTU1 and  MTU2=20

or=20

MTU1{MTCLKA and MTCLKB} and MTU2{MTCLKC and MTCLKD}

The signal feeding is same for 16-bit and 32-bit phase modes.

Note:- I haven't tested 32-bit mode yet.=20

Cheers,
Biju

>=20
> >
> >
> > b1 PHCKSEL 1 R/W External Input Phase Clock Select Selects the
> > external clock pin for phase counting mode.
> > 0: MTCLKA and MTCLKB are selected for the external phase clock.
> > 1: MTCLKC and MTCLKD are selected for the external phase clock
> >
> > > with overflows on the MTU1 register incrementing the MTU2
> register?
> >
> > No. that won't happen as we need to use different register for Long
> > word access
> >
> > These are the regiters used
> > 16-bit:- TCNT{MTU1,MTU2}, TGRA{MTU1,MTU2},  and TGRB{MTU1,MTU2},
> > 32-bit:- MTU1.TCNT_1_LW, MTU1.TGRA_1_LW and MTU1.TGRB_1_LW
> >
> > Counter in MTU1   MTU1.TCNT Word MTU1.TCNT_1_LW Longword
> > Counter in MTU2   MTU2.TCNT Word
> >
> > General register A in MTU1 MTU1.TGRA Word MTU1.TGRA_1_LW Longword
> > General register A in MTU2 MTU2.TGRA Word
> >
> > General register B in MTU1 MTU1.TGRB Word MTU1.TGRB_1_LW Longword
> > General register B in MTU2 MTU2.TGRB Word
> >
> > Cheers,
> > Biju
