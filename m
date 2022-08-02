Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7223587759
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Aug 2022 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiHBG6i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Aug 2022 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBG6g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Aug 2022 02:58:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2360EA;
        Mon,  1 Aug 2022 23:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLFG4HMjNaLCcEfaMaaOXTnqkp+2wohv76VfpgVO+qgyk4jv4K03/n/gSuqqqC0cs/ko/AlA/ka+3zw/gCGi/Mx+9htsncdbyfjqStqFQrmzEDhcFxXKw5P5pnIKLyMsv7wLoTQiVVp5Q2jYp0eNKoVU9cyHVc15AesMBgwC8VvAV1tXBh5uOJ2GqoGNhLB6Ni/OUcBcYOIpKbiFTJ/1nFgPe4dpUTQwtpcy3d8cbGW/AyCSVerTctCNK0NyVdmsja1S3yohImYJihHFoqrMPoeFMu3Rg/zXWxanBu2PzAyiaFOOKjZI6A9ZxM14cxkqFbBMdIje1qbJc3FjaEdGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGdKH/ITPM8aCJCLkQcMEg1J14KdTI2OvZPk/QTEdTA=;
 b=aU7vDQFt8t9E+IFe12+Z9T1Dfaygxru0Ekp487EaZEY6O6e5giHjDmUUu8tm5ZQCxE+eHV7kp/6QjsIHdyF2cbEzkEhVDio1pePQb26SAac0JEk772PG+P3VhV8Znd4PJydX4KjkLCm3s7cQ1G9xoOJ0GwsrRTKIUF1SjWBAiGt3eO/PPzHYRNB6H0TC5HWd6n2KxMZbEerO8fNQaHRNSag286HfNHJ1RIB8KLiPdIzHfFxgX1UEy+vTU1DBzoXadhCSdmJtCV5leQw28IWdXAm5Q7Te1qIyF8t9LUdE9FeNPh351T65jvXpar8jZdvH5QR0IsCp9SgUtiAt0quKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGdKH/ITPM8aCJCLkQcMEg1J14KdTI2OvZPk/QTEdTA=;
 b=Dz8FBJ3BRl6s22VknM+hqSVCxO4DBWswVmes+dGmCKZLObTISG/FlvOkF1Xeh6zsYmRDKvhL8gLzlaVzflnLFfhfCnTvL6cSJcghnsY2ARbqE6XxURbQtXeUDbUiZTira2auQcJ6wxI7ktT+TyW0DaIBQHjUTveMHh+y9eMx828=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9915.jpnprd01.prod.outlook.com (2603:1096:604:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:58:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 06:58:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYop6viWpAzgfhNkuf1fxYJomgoK2YlLCAgAHZcbCAACgiAIAAnMqA
Date:   Tue, 2 Aug 2022 06:58:32 +0000
Message-ID: <OS0PR01MB5922D8B0F2FFE4D86395138D869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
 <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
 <20220731145107.iepktigt4g63ranr@pengutronix.de>
 <OS0PR01MB59228AB5226BD45C6E8C5B70869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220801212916.kzs47wj3idvnaggz@pengutronix.de>
In-Reply-To: <20220801212916.kzs47wj3idvnaggz@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 887cc234-df6b-4e53-004b-08da745469c4
x-ms-traffictypediagnostic: OS3PR01MB9915:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHSHVobiU0BYl3N+dx9Gb/H8m2kItqUyzRsK/CnfnEj2K1Lj/6IWW36QsIfbfrWg19BL2enXBAVBHjyZYnYRuo+tIANavavhQlth+FB5ANl7Ygn2YZzv5RlwrLVbO7yB9LmuQehCppd8b7AsywL17jkrFmIBCC/5dRf+JZLGSte50vA9bufA9OEMbJZJthcZU83cCrBcX1SfGHMWP08zTmv4INxyvoPLMfAb31eucXkXaslm8qKpB+vE62JuuR9p+Id9SyouN/9woGNglmm6GwqalE4T6Hs+h0Kxphppb6vD/cIjzpvFJmJ4ZyYULbc5CH8KCavJIzPQg6v8Rro08xHTg3+WCCdXno9ntd3wmDf++dVj81FSqg2byn54Wkenf6PhQVZ1574t79L66T5VPnYf78H6TSqseEXhFktPnSS/NFjw4gH+CqPsOMYykwCgEuAeU5MWSYxQh8CKhJNatd1jQ9GkMoxSC7UGDDcBro0KKPl62RvwJUPyWN1bthlabBaq6+g9DAfIJ8H8bG4sCkbzuIBr/SOkHMa5QUrQthcgevMQtUgmozDwCShE/poFJVsnHstkMBxUVNPlNkBNtNsTDtnPzi+BNB5cAALvJqI8r/D44keGZGSGX6V7HEGEljKek5C3TV4HrbhQQm8hr9yb6Nxae5Ng0co8d+rB4fr81MI2zGy22PmYXIeoqbYUHv4PTn7ilQthieaZaJJb7nCWeGdUrIAbDxaHOdQMh6GWvjtj51SETFC1nfvFUtkSsoMncIz+OpFrXbFGmYY6EnkZFBLQloEsuDL2rfOqKiuW22UM4hfE1SPbBzC1CIt7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(83380400001)(66946007)(66556008)(2906002)(186003)(8936002)(66446008)(33656002)(52536014)(4326008)(76116006)(8676002)(66476007)(64756008)(5660300002)(316002)(55016003)(71200400001)(26005)(9686003)(6506007)(54906003)(6916009)(478600001)(41300700001)(86362001)(7696005)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jw9kmBbvA8pN2gl0FgRYr7QexhgDt4JRMRHMshlbU2A991ZDa2aD/vpNDa?=
 =?iso-8859-1?Q?ykdSElgDjK85Ce4bsx7LJuHea8K4pnPRJcYsXeeBenysboooaoymuUhTVZ?=
 =?iso-8859-1?Q?lfXtuql+Re3B+bo3UQOatMFfQOjqbOlUvnb84powER8Lkyef2HQiYaBOVy?=
 =?iso-8859-1?Q?SH5Qya0obLHXoSA19JcGGlqkeiqfqbbBG7oP+Qzo9+H98zQaaBkx7nzdmN?=
 =?iso-8859-1?Q?Bi/hyu3y6pZAUXZn1RfuoerLzSYmgxxX0J67G/InVSLb2x2pOGwfdYCEVn?=
 =?iso-8859-1?Q?3AJ1F3J/6g1A2QheZIFi2HXdxiEvhRc5rPIVdgwNLqq8A7KjIYBHZIc/zb?=
 =?iso-8859-1?Q?H67fgrEodwEsk+oiwZ4xahH//b/7ziDkoMGWctEed7SU6UTzsrdoyQURPN?=
 =?iso-8859-1?Q?nkPeSUnwdP/J41wTqluRcrHsi1G2hJQEbqZARebnt2GmDv0JImSoR2g3rq?=
 =?iso-8859-1?Q?T3TcmwKPCp2k1aAqBnm6EtaNHSGW2mCakqks6hoORClEoWf4DXpVR55M5K?=
 =?iso-8859-1?Q?ymx6bJOz9fKgQ3zi+CzPDba9BmlZMPcesmWNR8kpBq0QfNmF8PtAT7CdVt?=
 =?iso-8859-1?Q?J/v26/BER1U/bhEg0pvNFYLV9B5OfxFbBbmv5IM01rUE/fIF//VIC+LKKj?=
 =?iso-8859-1?Q?7OMZbjlJSa7QA3vjDsdB5wqRjv2Hn5LHkrA5+fBd0hHL/IReSOo+w6MEgx?=
 =?iso-8859-1?Q?WX5NajmuG93Lw6Lb42JqmhB4LrFIUY/GJGft9jjYH92SYZrHpCqIS2sBJc?=
 =?iso-8859-1?Q?nWIDnB73DA6pC9s5x47xGjIAAWBumC7xWckirRlnN6+P8UgUz/GgvR3Lfr?=
 =?iso-8859-1?Q?Auv7o3S8lThKsLYdoloY4h9niqPIz3ycekt9emKjKohedk/8TOaiCWY/pc?=
 =?iso-8859-1?Q?4b9ZNRTX/UfFKnrJi2wP8qCehcbWcB2o6yYpH9A+lHAY++ootZi/QUdzYQ?=
 =?iso-8859-1?Q?0WgKSOrsY4XPq5NQiDcwgoONSDTd0rUPy2mFwfAaux2ACM/oVEC10DkMTo?=
 =?iso-8859-1?Q?aJSah4HlJw5MecWClzP6PG6DlbWAjVcRZxuutG0oqAsJ5uSwrhiVFcHL/4?=
 =?iso-8859-1?Q?Sj5BiodAlwynPKAWOFjbDw0K0E0ehI1peFOCE/k4QFgJk1+CWZSpj0n7AW?=
 =?iso-8859-1?Q?lMSY9ucxkeBhORU1iiBnX2fK48KplVKG1FJYvJHoswqzQg+Ql9MgButYlQ?=
 =?iso-8859-1?Q?v3WPvgs7aHkYRsOq69wpvXpi+2+b/J/kUSOxoLHGUUSxiQhSh4pCzKUCWT?=
 =?iso-8859-1?Q?g6u9HwlHMieeLkXuxUhqxQVDiQftNDrYCHF9UgDMUGPVc5QhZWRCxZEQeo?=
 =?iso-8859-1?Q?UO0w4wFNW1w4JsCyj0AMRwe0YurAfAUjtrNZ5wthDTHuXJ4rYREK5oJH57?=
 =?iso-8859-1?Q?71hlLO2G9GswLVD+/x22tFx63L03Hpbiv+hOYdc8RA3d6xPQ49Jl3TVMlT?=
 =?iso-8859-1?Q?QfBLnvb+KlRSssWSe3etrHflDTn8nGDw/+lAwbwsuW0ETqaUTSWosqAAjF?=
 =?iso-8859-1?Q?ei46SMUnWc8dbSyTcoDu4iL9n8dsfd42/e+CqlJLPPAfa/vGu6vyIRNTFj?=
 =?iso-8859-1?Q?ijE2qAT7CeCE2k1kpTA9vJybPMSsUFP/J5+CIiC/oyYxP6vVvpemMOXADm?=
 =?iso-8859-1?Q?xhJ5d9a0gmiYbeDM3Y3f/NZC5Cx3diWkR+xFPNsRPP45K6uxJbZM/0nQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887cc234-df6b-4e53-004b-08da745469c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 06:58:32.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+nJYMT/XNqEjzuL860xdjgLldUHk/3vAjaj0GNCyPl7Bt1mJf916ZvEiYd0ZmWjrfUvTneMTJYaG+GYHLL81GrH2KDFnaMP5z1oyQ6CW+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9915
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

> Subject: Re: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Mon, Aug 01, 2022 at 07:24:06PM +0000, Biju Das wrote:
> > > On Thu, Jul 28, 2022 at 05:25:26PM +0100, Biju Das wrote:
> > > > +
> > > > +	if (pc->pwm_enabled_by_bootloader)
> > > > +		clk_disable(pc->clk);
> > >
> > > When this function is called as part of remove, not disabling the
> > > clk is wrong, isn't it?
> >
> > I will remove pwm_enabled_by_bootloader variable and use the below
> > changes, so it is taken care for the bootloader case.
> >
> > +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +				     "cannot get clock\n");
> > +
> > +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> > +
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader enabled
> PWM and
> > +	 *  is running during probe().
> > +	 */
> > +	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> > +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);
>=20
> devm_clk_put looks wrong here. You only want to disable, not put?!

It should be ok as to free the Clock, after getting the clock rate as the a=
ctual clock=20
management is done by PM routines.

Bootloader with PWM on case:-
------------------------------
Clk is turned on by "devm_clk_get_enabled" and after that PM manages the cl=
ock.

Bootloader with PWM off case:-
-----------------------------
PM manages the clk(Here no clk framework involvement, after freeing it).

Please correct me if anything wrong here.

Cheers,
Biju

