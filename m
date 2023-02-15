Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7856979E5
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjBOKb1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 05:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjBOKbZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 05:31:25 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0EB366A6;
        Wed, 15 Feb 2023 02:31:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlGlsAhh0NiUB/4sTHAw+YpBxRSXvVBRmA5hY3qIqHOIcSv+AWmkd47nM2uvcelPBvkA7IKkgIMC0+UnIlGfBJsWwM6bcYTZzqLv4fbPYvr3f05CGG5m+jVzMmPLCWJfgmHFYCXTEZDJbFau053l7gpSSz/n7DwZYdswh8vQ/aB1NHCESSaOoQ0KJ1XT5S8N3d7xw68y0YEiQW//M2YdxI/B+rz/TLob1HIngi7gr4QuU3asaqolSeUiB3ra2RJ1oc8zKc/nOE8rz4h4TVtyuaEuQ+i6fnStdEUELfxtHlcQVDH5tQW1ETWRN0/PQmcFm8QYX/e6SHDyrwm9sD36nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHn9+m0tz6bRyngL84zwF6NdT/i5uF0kQLV7oz7e57E=;
 b=LorI7Rtbb2FryLhIWeYw2HHfJmH7o3l5GIo7x5O48WkEXC0mA92Ss5hL68+INPZCJITgYiE4mfVVifYmWplGoESCIgSSXgdXSxHaCWHzf6chi7Kc2dmAKMGjLjvKtXJQk/fXBNhwAOeJz+DMaN2f51G8wveL7Lh1n5CDJe5Yvn6jlTFMyeNQT6zOrIdww8ja4hqqNPALANAQTyJ9XFuu/8zW0eVVxnA3KDhPgZlc4ZWVeg0xN6RCVLfjbNfRoycMleAB3OxAb+wCjn6pV1AkryPFTuQ7ENGVKTLUDde86fafdf6xkY11uhVRl9PgfGgZJbbJ7sxCmdPKQuEh3gC3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHn9+m0tz6bRyngL84zwF6NdT/i5uF0kQLV7oz7e57E=;
 b=lq+VwFiPl6O3pcu9Ual87i1tvF5K6dyAZbHFbXLjrdd8YhWBCmEUhdxV3+bGPtUeb/ygVHe2Fd7PDDlfWZRxBhP/T93iRgG+9OCuPNKoe6iTanxWeHcQzCcmtqtMdOTK6/an94tfOc0L0GNecxVHoRXbH58XK3qSEeiYKQ0H6yc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7987.jpnprd01.prod.outlook.com (2603:1096:604:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:31:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:31:20 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgAAWbpA=
Date:   Wed, 15 Feb 2023 10:31:20 +0000
Message-ID: <OS0PR01MB59227E0E659C292D775474BF86A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
In-Reply-To: <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7987:EE_
x-ms-office365-filtering-correlation-id: fcb4bcd6-b698-4957-ac68-08db0f3fc796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NNHEVk32pfa6u6GtnCPEPENwH9yIVDz29KLVVstivOlYThFL+K8XoI1wyT2zan4uxFdHgXgId82beZyN2bV4nOxtM7grPMwS41vBjn8F11yx5sg6/tNd51zEP2GVDgwOpUhVfcex2aztT43jKphLkBbt8S0B+c4okM8vCQ38Q7voskKxztTOii1KKg0NpaaKUOSEM3HayxBVWM7I+Y60tdwlSL80NjCfl2tuGT9ug1cQWBipQnNIyJuYTq/5hmJf/xU5eap7Cwppg3xba40nmiGo5L2yP3H3vQjk/nfm82XFqX0D6fWvhOu4tErmvcdbISYE92FGaolZjLdxYLCbm2Gh6/jg1lCkb/hNsCjifnoxZiATqQfwxe3ZQAZLZ8TywqGU+x/N0m1/YGli/ngiq73bR6/zUqsLPT1BITa0ixz5dC7YsFnIwTLl1ZGL3vWTVyMZJHdLZkXfYvI4gzHRbo8PUfzyAjtRkTEYV9TJCeErv8yOeUsWjBNRYDNO+PfcJL9lT3EE2fXgyDaxGZFpf0pkXlaTV11ehVRBUSQYYTcci47D2mwsKzd40GZ/cXd+e8ZLbPAz/wPhNvSl0N1nbPbyDzzptsKIFQqyKHJAfllXHuSvwfeL1NEzukAIsujPdmKuG36SnssjiSIudm/PAz7lpehhXL8lveBJWnNQdmWCGk5+GN8m3TIEui6uXP7I/blLx9YULHqkOcSKgSkK7T2ViITnrbvsxDXD/kgX/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(66446008)(122000001)(38100700002)(38070700005)(316002)(8936002)(52536014)(478600001)(66476007)(4326008)(6916009)(8676002)(41300700001)(66556008)(5660300002)(76116006)(66946007)(2906002)(64756008)(186003)(6506007)(9686003)(26005)(33656002)(54906003)(86362001)(83380400001)(7696005)(55016003)(71200400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sTemoy+VO4oeMhgf3eidSL2jcAG+6N+peXOebEITenhfsQeRQMoA+jl7ZE?=
 =?iso-8859-1?Q?c7T19J0i5wPSArW5A3cWRiG542fhp/f1fmhNb9X8sEcNrJII4IvjC+y5le?=
 =?iso-8859-1?Q?BnIUsGbhNEKji/OMHmA8+5K9AEEsunsdlbi6XsarE5YNuxoexbQ1Tp8Ku7?=
 =?iso-8859-1?Q?kMSLJN6FTZzrjiJZSgrEGyR5GvFD4PW8KiSVg1Z51t7RGz1RfN7oXzyuuq?=
 =?iso-8859-1?Q?SYeCu+d5VjDRYN8/1zVT/ouYXiCiV4ryQabeCciS9DvZh9HOtHK/XlVIqt?=
 =?iso-8859-1?Q?ugD+rBQF8rWaVxjLn2g+l0ALb9e5RFVEkP4fyyLSBfl504xcY8KHKJkgZP?=
 =?iso-8859-1?Q?y9MCFfk8CNbINNO8Sm018wTG4pq8VOoZVNA2bPR+2Insle0wMTumWAs17l?=
 =?iso-8859-1?Q?iG3pTxMsxLv918WyJi+72FA1JUun7aD3eNugQ6f8eBn+051L+/C0817ScA?=
 =?iso-8859-1?Q?6QBAMuwgAApZgrGRUmgTluAZaxqJ/HUCvr0xoDKsL32Y1bUhfqWGAFKDJn?=
 =?iso-8859-1?Q?71MH6v2aBetPW8Wj9q1GfSwtlrah227XW+FeAhp2BvmYW83jGftkSw7BWq?=
 =?iso-8859-1?Q?oBH5j9RJCqvNFCssqoPLrAuql+1aUQIdAIpTRhjvx1UC7XB603c7gM6Whu?=
 =?iso-8859-1?Q?OZqYvFXHUsBEHbcCAF+5I+lXB7api69W4Jxnr8y7cyOBegFAX4dF+0gP7D?=
 =?iso-8859-1?Q?g/+MhvZ4s699pd3k6sgigVGDstKuM0xa9bF2fh+xbZN+PtXmKWiW1JYMwP?=
 =?iso-8859-1?Q?kFxGqeyOg+xzqMjt3iFiYV3kYVAcgU4sc9sGdiOi6n000WRLK+3SkunF9p?=
 =?iso-8859-1?Q?gs5JTaHrZl9m71ALvdQeAy66b7RFdOXsEGMVMf3e6ZDhS6WGhSmcmDTneJ?=
 =?iso-8859-1?Q?amdwwATROCxeA9zfccXgiO1lwz63UyPIzya+sazFy47GHk8ILt8+nH7wXv?=
 =?iso-8859-1?Q?c+9rjRzUFwUNzQg+nu+oe26MBZXz3E7tIwq2HjterNmwcpWHUyQ9V101cp?=
 =?iso-8859-1?Q?jtWwhQ1KmC7v6QseFNGtdrXCNBULzLYZL8q7+fK9vzZs3fCihdg43tt5oa?=
 =?iso-8859-1?Q?ELmDGNrgVFGxhzE3YI4G906oD48LLJhudjhqWcPDr6TVJlFhBCTRRO4Vg2?=
 =?iso-8859-1?Q?63rLWavD2vuq+2dhBz+5xPDDWyKZFkMl77DX3qpWGp1q3IPeKZHrckW620?=
 =?iso-8859-1?Q?1zKF8dugdN8mElQoCi0lY0yTf+iD+6XYx8FAhbMGgeW+3dFEWevb2wlfLz?=
 =?iso-8859-1?Q?pqw2DFH00FWDZ0YOOof6THg98JJ56oXJBNP8dTskw41J8tb0Bj7TZhL1DE?=
 =?iso-8859-1?Q?ZlmgguyUAZ3+eJENzYz4e7OTbaM5eQUTHkB+pRoGCdSICOvybQ3UyJQjKr?=
 =?iso-8859-1?Q?prSxYQY8M3lBw/yqFbwoKxI6iFl9CGUPIi4cFAP24Nerr5IvLn6QjnzqP9?=
 =?iso-8859-1?Q?w4Dns4eHJQrVxUHuaI7XdB3e32nEnRufIRvlNuvWqb+NW3AVWSNu1VRL3V?=
 =?iso-8859-1?Q?Lafr8uD+g0ajd/hq7rEW2Uf/qwhLxBJcJBpSol082q6HpAE9uvgJK/x5NM?=
 =?iso-8859-1?Q?z7DxXYbTj61PcKIl9fE6VuIyHHF4RCV4AjSN63E7ygmFsZ19e/yt3/h68I?=
 =?iso-8859-1?Q?2oWfnoYCgnPr7v0qPv2NSjkgJ8E+JTYGBt87IIQy099111VY0bJaFpCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4bcd6-b698-4957-ac68-08db0f3fc796
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 10:31:20.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voiKqAza2A7/m+y4a5mx63N2hp1q+tDtAaMrGuH4jty0FF6Uk1KVhu/h661xocza9zP+Kvv6EzeKQU+FXiIm3nCLXW+uC17EwJsL6JJmkL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7987
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> I'm working on my review backlog, sorry that it took so long.

OK.

>=20
> On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > Add support for RZ/G2L MTU3a PWM driver. The IP supports following PWM
> > modes
> >
> > 1) PWM mode{1,2}
> > 2) Reset-synchronized PWM mode
> > 3) Complementary PWM mode{1,2,3}
>=20
> It's unclear to me what "PWM mode1" and the other modes are. I suspect th=
is
> is some chip specific naming that isn't understandable for outsiders? Wou=
ld
> be great to explain that a bit more.

I will give some details about PWM modes mentioned in the HW manual here.
I will respond to other comments later.

PWM Mode 1
------------
n =3D {0,1,2,3,4,6,7}
MTIOC0A:-MTU0 TGRA input capture input/output compare output/PWM output pin
TGRA: Timer General Register A
TIOR: Timer I/O control register
In PWM mode 1, PWM waveforms in up to 12 phases can be output

PWM waveforms are output from the MTIOCnA and MTIOCnC pins by pairing TGRA
with TGRB and TGRC with TGRD. The levels specified by the TIOR.IOA[3:0] and
IOC[3:0] bits are output from the MTIOCnA and MTIOCnC pins at compare match=
es
A and C, and the level specified by the TIOR.IOB[3:0] and IOD[3:0] bits are
output at compare matches B and D (n =3D 0 to 4, 6, 7). The initial output =
value
is set in TGRA or TGRC. If the values set in paired TGRs are identical, the
output value does not change even when a compare match occurs.


PWM Mode 2
----------
n =3D {0,1,2}

PWM waveform output is generated using one TGR as the cycle register and th=
e
others as duty registers. The level specified in TIOR is output at compare =
matches.
Upon counter clearing by a cycle register compare match, the initial value =
set
in TIOR is output from each pin. If the values set in the cycle and duty re=
gisters
are identical, the output value does not change even when a compare match o=
ccurs.

In PWM mode 2, up to eight phases of PWM waveforms can be output when synch=
ronous
clearing is used as synchronous operation in the channels that cannot be pl=
aced in
PWM mode 2.

Reset-Synchronized PWM Mode:
---------------------------
In the reset-synchronized PWM mode, three phases of positive and negative P=
WM
waveforms (six phases in total) that share a common wave transition point c=
an
be output by combining MTU3 and MTU4 and MTU6 and MTU7.

When set for reset-synchronized PWM mode, the MTIOC3B, MTIOC3D, MTIOC4A, MT=
IOC4C,
MTIOC4B, MTIOC4D, MTIOC6B, MTIOC6D, MTIOC7A, MTIOC7C, MTIOC7B, and MTIOC7D =
pins
function as PWM output pins and timer counters 6 and 12 (MTU3.TCNT and MTU6=
.TCNT)
functions as an up-counter


Complementary PWM Mode:
----------------------

In complementary PWM mode, dead time can be set for PWM waveforms to be out=
put.
The dead time is the period during which the upper and lower arm transistor=
s are
set to the inactive level in order to prevent short-circuiting of the arms.
Six positive-phase and six negative-phase PWM waveforms (12 phases in total=
)=20
with dead time can be output by combining MTU3/ MTU4 and MTU6/MTU7. PWM wav=
eforms
without dead time can also be output.

In complementary PWM mode, nine registers (compare registers, buffer regist=
ers,
and temporary registers) are used to control the duty ratio for the PWM out=
put.

Complementary PWM mode 1 (transfer at crest)
Complementary PWM mode 2 (transfer at trough)
Complementary PWM mode 3 (transfer at crest and trough)


Note:
I will respond to other comments later.

Cheers,
Biju

>=20
> > This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm driver
> > by creating separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v11->v12:
> >  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MF=
D.
> >  * Reordered get_state()
> > v10->v11:
> >  * No change.
> > v9->v10:
> >  * No change.
> > v8->v9:
> >  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
> >    cached this values in rz_mtu3_pwm_config and used this cached values
> >    in get_state(), if PWM is disabled.
> >  * Added return code for get_state()
> > v7->v8:
> >  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
> >  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> > v6->v7:
> >  * Added channel specific mutex lock to avoid race between counter
> >    device and rz_mtu3_pwm_{request,free}
> >  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
> >  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
> >  * Updated rz_mtu3_pwm_config()
> >  * Updated rz_mtu3_pwm_apply()
> > v5->v6:
> >  * Updated commit and Kconfig description
> >  * Sorted the header
> >  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
> >  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
> >    __maybe_unused from suspend/resume()
> > v4->v5:
> >  * pwm device is instantiated by mtu3a core driver.
> > v3->v4:
> >  * There is no resource associated with "rz-mtu3-pwm" compatible
> >    and moved the code to mfd subsystem as it binds against "rz-mtu".
> >  * Removed struct platform_driver rz_mtu3_pwm_driver.
> > v2->v3:
> >  * No change.
> > v1->v2:
> >  * Modelled as a single PWM device handling multiple channles.
> >  * Used PM framework to manage the clocks.
> > ---
> >  drivers/pwm/Kconfig       |  11 +
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-rz-mtu3.c | 485
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 497 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
> >
