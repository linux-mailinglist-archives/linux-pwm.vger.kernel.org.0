Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADF6AD9AE
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 09:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCGI5l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 03:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCGI5j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 03:57:39 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6651CA6;
        Tue,  7 Mar 2023 00:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cecP5EHA+HiNJ3wQha+8lhWaGLYOh0uapeY/82rVjnq42f4Rhc8t9EH2qvXpW4kfCkwYfuv69Qk9TYcNe5GIvwFGBN+XNEWfLO8RQOIAXWbWnswIr7ZS4lFbWGBUG19ileV6Hm2C9WN5x1yBIl1kWYoTiPd2of4a5+/nr5+TBiU7BjeCCK9BhNfSaxa0Im16zPFhEmss16YhFiLNxZGI4GHuKEvi1642NaZrrnoTXDfb/H+BXEffgIzaPHfcZM8aZja/4GGeWTtrOMimOJnlRBNceGZAJKHSSJ6e24L9AHs72jyopA/cWjwb49OxY36KFKPJzUQd/zpECta7I25A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOCithZ6qeaR+2Y7VbT8iV2BDGRwftGIVzWTMupc/PE=;
 b=ACOxMHUh+YPdcZFXFWvDAgb7iK3RlD3brDKUW7JSlVSeXqdkZ1LwJLtm658EknILeYr7TalEX98eeicBYdDRHZ620bisZr+prHmGN5kpiWAH/kqRkpSqUGtVo1T8OfNEJtDyIzqv56CfkxGsjqLgvr5X2oZK8ePJJ0xwCR8H1ofAHhYRm/ulrRjlnhFFONjZCV+jYcffo4R7tVqAowFNoZuMdYhkPz2Ab1UGqjnKVPVaEqZ92mNfqrYL21tZ0Hv1iC9te4WSwNP99X0aKhQ0YghBZUPC29HV+fs5N6EpcUz/p/oNDK9xExxJaiwvSXn7q6ycWzqUG9IfTAyoYK11fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOCithZ6qeaR+2Y7VbT8iV2BDGRwftGIVzWTMupc/PE=;
 b=TWfVasoGPvNC6aFLCHGkyFD5AJTJP8iEeRofH2ScWsuZhBIdOxd/sbdSBMhF9ebi1OTgt7AeDk4JFGkks4JNSOaaD5q9vcuR391gdQ3X9nPNiyPnj+B0X8a12LNg/5PCAod9/8vJE4JKH1qb3CydeMqBYu8loR46TzAJunp+Cz4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10888.jpnprd01.prod.outlook.com (2603:1096:400:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 08:57:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 08:57:31 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [DO NOT APPLY PATCH v6 10/13] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT when both outputs are low.
Thread-Topic: [DO NOT APPLY PATCH v6 10/13] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT when both outputs are low.
Thread-Index: AQHZUAord4CJos4h6EmKu/11Xwodpa7uabOAgACbXwA=
Date:   Tue, 7 Mar 2023 08:57:31 +0000
Message-ID: <OS0PR01MB5922373C5D31540004F2546586B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-11-biju.das.jz@bp.renesas.com>
 <ZAZ5r619EBCmehiI@surfacebook>
In-Reply-To: <ZAZ5r619EBCmehiI@surfacebook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10888:EE_
x-ms-office365-filtering-correlation-id: e101e9f6-36fc-4b66-e7d1-08db1ee9fc3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Nk2aoxrH35QbK8O70TTTD5uR2ILepFSDXYYJabshL5u2q5MXd3KZwnN/wmr2tXCEiYqp4bkeKqvRxQLA6GvLNwhPKYbDZY4xw4q6BYh/Lm2wzaBMda4HSLOqA3wu/KGSvVhllsOavfgBATHnhvUehd2JuT5KuyhZiwOmtjrfuVFfPZvXwefaTrB5ae2RnhnRoz8kNiI59SSbdyIUpOG9Q+NRv5UwxT+R6Y5qrshGon4GScPvbt3q6Urssu1lyADFBheVOq7MV0L+3G9E/R3iwKGSdd57xuLsUW5F50tOQ6CtliLbBXSl883SO3sgkQVrpaaqBS3Cog2WAJXr+smq8vVhjNZ/3o0iJsTkrRROnmyBFJnr+cvsNeZJ0XwtCkP/aXbEJYVj3DrC8sAgUtjC9bjTO+kNzSl0IdDkMDvMnNssijq7zpXychelP0ZhbFtsWePKmc2y1JL3CBaZm9grd72BHi/olFvR2TlXTtWE//a3cFU0cVuvBIEOlJ4dcLTAm/aoET10HWfGfD7Q9ShysCf1O3v/pX/BCzguhQnKOU2bxdMGlPavB3IYBUKOZGlUPbujfm8MjC7HNRTSdxU27i6+XkdOisAaWIBnyaDhYYwKt2gzTRjPJ+3CqU/nZFXunnI8wDgiOlDd6Vftmxd7RirFsPz0PwMfV4bzH5M5/LOybSzR6ywGe+sauqEdVSB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199018)(55016003)(6506007)(9686003)(186003)(26005)(316002)(41300700001)(54906003)(76116006)(8676002)(4326008)(66946007)(4744005)(66446008)(66476007)(66556008)(7696005)(64756008)(6916009)(33656002)(71200400001)(478600001)(107886003)(52536014)(5660300002)(38100700002)(122000001)(8936002)(38070700005)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?doLUDhJ2ENsa/F0xANaNZ54y3t0zNBjtVMWpLK5Eb6xvBCukFV3ouaFmNR?=
 =?iso-8859-1?Q?tMiJA9k0+QV6VD/Tiupg4Cd5uMDX96o70nPkXT7pvTqWWyeJKXpg7moC0K?=
 =?iso-8859-1?Q?6ys+SU+mNBRbIVT/9QEWnSBgh7MkmdcHvSWxLOh5Uln8Xr8GNO1Yy4W3HR?=
 =?iso-8859-1?Q?hX0tpArWhiB/Az8CLkTRkvX1xKqxV5eSlwDzHYE9YpHRPexSyxQzZS56D9?=
 =?iso-8859-1?Q?xHkd6omGwqfcC7p+2IVedbcOba1FR/zhKrnPPQL6MKTHUXCIrUKFuaSRmU?=
 =?iso-8859-1?Q?cvd4gcL6joFD88gVqjC2Ek1slfuGNySw8wU4qb4ck+GX6fvEf/Yx3rPQ2L?=
 =?iso-8859-1?Q?W+Dcqj3gs1vLeN2mw2HHwGq5Ep/Jwpfu5o/AnEhZTYmH3qEB/xDYiQC4V4?=
 =?iso-8859-1?Q?mvYmc+VVjX0OsXvTpbcIM/wUHXTsF0ZPdIsY973pyQg/6jcDqamcKQ+FMk?=
 =?iso-8859-1?Q?F1cnWkjgbUgttYRenJGJExo96GhX7BgLHJTXAqjzPa1VUyFKm2c90by0IJ?=
 =?iso-8859-1?Q?VQJLNVMfq71fWA0pa2N7KiPm699D1Z+B1Xuotks1z0vJkRb6k+dxeYXChx?=
 =?iso-8859-1?Q?6YVx/osDktsMi0emUy3GaPKaLDY4uuAtM5N3vs45LcRjZUzS3RchhzHpkN?=
 =?iso-8859-1?Q?zaXlgQRIYvyg3anpKmR0DN7SMFeGjduqgFLg0Rj6WNXqnAdN2+vGx2FRh3?=
 =?iso-8859-1?Q?ZY1ovFqVjCtokd5aV54iW7l0NbxI5ZaLmXOhQbUqh0AN42EPAPdu+/u3cY?=
 =?iso-8859-1?Q?0trGcu9vk86u4v3oIJLgziQzz1m47j3fXPYwvuMbqO3VZVfLGNXWIQHAoZ?=
 =?iso-8859-1?Q?ntp8dx7wWLrzJqRiPtF0hQVIeyzlqlsDii+SSAQ8p2Il7ftrab0ov2Z9wJ?=
 =?iso-8859-1?Q?p+ZkknbeTJ0BHsx8s5JNUL81lgh7v6wteGbdj9BkT5kXJT6L2ahUoBLXP4?=
 =?iso-8859-1?Q?U+NO7wQwgwuCut0XPBYxmhrSkGLWMKF9rG6qPgh+GPkzA4m5VWJLJt6NSC?=
 =?iso-8859-1?Q?YP+LYugPZwqciDLnQxsaP4RVpSxbVs8MHYmI2vWYVGrH6vZF3Y+2SFG52l?=
 =?iso-8859-1?Q?xDiB16sranrcjRDy1CC43vD01AGAjdJNNCh2Vgy5nU01u/u735E7mkY/Ga?=
 =?iso-8859-1?Q?yK/SD7828vbiLAAYzyv+LrP4AUGHK/m0vm3XIm1Zo56JNvDxMG2dBTeSL0?=
 =?iso-8859-1?Q?QLYuZ9FEKKnYsenWN7QSwixqkU6CCBNnWvltHiOTF+RqVwtSnxqQbTs4YU?=
 =?iso-8859-1?Q?I5i66Nbs2GbiBuOVycbf9tHHIfGFKeXzEArxtpXIgtUVApQYeAld5Z2ClC?=
 =?iso-8859-1?Q?cSPmrvCg34G5UqBJLFZw119IjFYWKG2TxJl9KVqfCtru9JbSI5hpatvZYi?=
 =?iso-8859-1?Q?CBOjWJEGMMM4RorsTdtRYavLxcRXX+sZx1ieYtIU1DM+9r/7BUzLqD6xtV?=
 =?iso-8859-1?Q?PF02IsFZPGNTAjtPeHUh4hQHURjA6PSX3hVOgI/WMrNN+F46KnHhnTDLy3?=
 =?iso-8859-1?Q?QPmOJuBE9x9tmpMAyzznoBtrw0Ci3eEutIbjAblw1eUKDyzKErBdHCFVEa?=
 =?iso-8859-1?Q?1Yx6Mgc8P4h21hK17kOfZFyDyJJyQEbQZRpsR/pqfQN4CDwzn9Yq/2RLyG?=
 =?iso-8859-1?Q?u+Vwd2vFFkR0gD3Scn4FOeK1yL/fKzl258?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e101e9f6-36fc-4b66-e7d1-08db1ee9fc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:57:31.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pU93iiOtidzjl44nllVgURz7lz3smcMaT/aqRHPi0i5JBZX4I+p3DTGjt2tr9c90FN+M7LkCLmLTKtsS7ishROU7hO3xyArGzjLxfiFVlpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10888
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [DO NOT APPLY PATCH v6 10/13] pinctrl: renesas: rzg2l-poeg:
> output-disable request from GPT when both outputs are low.
>=20
> Mon, Mar 06, 2023 at 09:00:11AM +0000, Biju Das kirjoitti:
> > This patch adds support fpr output-disable requests from GPT, when
> > both outputs are low.
> >
> > Added sysfs to enable/disable for configuring GPT output disable
> > request when both outputs are low.
>=20
> ...
>=20
> > +static int rzg2l_poeg_output_disable_both_low(struct rzg2l_poeg_chip
> *chip,
> > +					      bool enable)
> > +{
> > +	if (enable)
> > +		set_bit(RZG2L_GPT_OABLF, chip->gpt_irq);
> > +	else
> > +		clear_bit(RZG2L_GPT_OABLF, chip->gpt_irq);
>=20
> JFYI: assign_bit()

OK, will use assign_bit() and remove the above code.

Cheers,
Biju
>=20
>=20
> > +	rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index,
> > +					    test_bit(RZG2L_GPT_OABLF, chip-
> >gpt_irq));
> > +
> > +	return 0;
> > +}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

