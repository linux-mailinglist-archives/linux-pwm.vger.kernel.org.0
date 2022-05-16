Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AB1527E01
	for <lists+linux-pwm@lfdr.de>; Mon, 16 May 2022 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiEPHC7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 May 2022 03:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbiEPHC6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 May 2022 03:02:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D4DFB9;
        Mon, 16 May 2022 00:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJEJJiLC1ZrkDkVAL8gBAFTO+XtBMb2XAq5eBj6jW6HBrO2NeC+6jaVteTw7t8HTTqKmhqxyB1s0s9AFnkNUNTqqL4B3s2/H9r4RJR6Rq0P4/NoXJKHHCwzgtzReZnImJlJauYyjvPX9IHw05pt1ZZEZha1r39LUEQ0OSLjehTczyRwIlG7rVWefNAJvmsM6RN7M3No9cgLuijO91kCE8sriK3La/8vrj5dp3FSQ1IoPlzahYF8h62A2lZ1Ge+kmfNxY2yEhDWRegdFQyLKjnELCmJzs4fcF9LGh4uRQT5B/nFSKQZFwE/L2nOqhJtBIhpMGZjh87U/6GdWubxFMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoPBMCM4txznCuyrL58c425r+vm2BuMgdmAdw88srCk=;
 b=Rll2W7cXrUPgYf5EOB68TnAiO9H86I3Ec1vqnm8xHi7UQS8LbBcTMGc8LeS5lIZnhHrTXYaa1USZK701uzLF5tcMxA8Clk0UufL5R7JIjDSMPf3x8JkRENZwrfjKkQxeDFEih0AIpOSrpE9tojwouttMjPGtZf3K0QPKbiRGSg+j58jwTgMHi5Rl15RPKPb+Uegj06K4qCNQfXB1seB/rJexGTsP+hdtvpeNefTu/DJbiHXb+lL2yiW+QsPg0lHz7iHrE5Ie7tzGLIU/VegXZ1rpLs3JMH7q90LjdcOaYqz9PuuR/g/YiRECVlfCaWvr8L9vReQZeVbf47Ip1o9Zlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoPBMCM4txznCuyrL58c425r+vm2BuMgdmAdw88srCk=;
 b=jqhHXQ9M6vfGkUTpMwImNPCD0qwZYCblDgaYzouZJupa5I1HFT7XObjE4cS4c1UODNhKizGhqV+uQQF9Zggb3VxFklWJsBCj+MB2qP1IXGliM1pxJZ5lbmHIG1IgK3ckHh6Rf3ITP9XUF9KDB4cVBI2nbCCxg9EtB1tJem6F68o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9980.jpnprd01.prod.outlook.com (2603:1096:400:1df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 07:02:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:02:52 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Topic: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Index: AQHYZHxHqAip1AUWpkCs1CVKkDSV2a0hGdEAgAACk+A=
Date:   Mon, 16 May 2022 07:02:52 +0000
Message-ID: <OS0PR01MB5922EFFE044995B99975B8C686CF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
 <20220516065140.kdrcihx5ifyeuen2@pengutronix.de>
In-Reply-To: <20220516065140.kdrcihx5ifyeuen2@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efae2cc0-7195-4196-eb14-08da370a1832
x-ms-traffictypediagnostic: TY3PR01MB9980:EE_
x-microsoft-antispam-prvs: <TY3PR01MB9980429245B50DC81955BF7386CF9@TY3PR01MB9980.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auLlbo5AtXKorWOjhMesAl/T3ZZxwaFesTXkcZUpzADRH1qWH3W7QGjt5J+p9UQVLd8wXTctu3uyofL7qg9p39xBVsSrRVwpFpvJpv62MOXy1mWjcQPB8aOqO3L7b+LzYZXUMEjK9rqK8Qh3yFW5WmjdeAflhffF0tg/IuFpcZaYFHKZaNuYFdCNl8lBU4DrIhJLSLhbLJbrImc1Kuk7SOJ/kV18O2uYeRU22pVvamqtS9RvCQR1P7KSCJueWhJxfIji+SHQ6JfSruC8e0B7pWqQpVYA9U7ypalYYH8T0YehpNC7ZfW5FoUODi8ksc2YW4sLl8/i/Ecolr5divn8uyfgLWFLG8KK9KGqE3Dey5BaA/3JpblhkU7ecJXiZRYiF/PRNWgKbpULY6+f56XkaIN0+l80Acz5BxdIVN+aXeJ2HbrJwCiXJ+cwDTYcNlbfH53M4fNTjJ51xNIu3Sx4jWVx4El80fgrBAJS9Vcs9nenrfm7YUWDt1YysN5p3QM3ZdgZ/vcOYQnzd2Zy+ONfXsFrRMDsoRv4G3qTNkRRlRbMYBdVj/3tk5reM/C6FTBDRrgllUGQVKrAx4tKeKxpWwirgFDKW4a4eWCoZg91vlTV8WoL6ySY8f/1igCeMXD24LUTwDEBS5JjgVwXuMxyagm2mZcRc9uZoHd+ngHwr0fI/10dzMiwoUfkJrnYdQq9GsW4JOZPD4wKFkEAv61sC2AMQjxzJJc3JmpEY4elZQyGDst9PB/qupzsweNhM3sUz6vIw3l5DoZqjFBkR350kgUNtmITGddyYX3Qqz9knI0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(86362001)(33656002)(508600001)(8936002)(76116006)(66476007)(38100700002)(66446008)(186003)(66574015)(26005)(5660300002)(4744005)(966005)(122000001)(7696005)(38070700005)(71200400001)(64756008)(55016003)(2906002)(52536014)(6916009)(6506007)(66556008)(54906003)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aAXR5eplXr5euFopWyA0cQIHvAM0Qw0EfoaKwoLR2UTM1KRdngSLqNwWYA?=
 =?iso-8859-1?Q?pjJF0HfDMViaoStIvc2L9J8HRAyXH8PmhihVKX06vvGyB2VCOZMJ4mChZ8?=
 =?iso-8859-1?Q?KGyrTOa/X6Iw8KbxRpyxstR88tbo6W0TNucG+pROi5Tbq2RhOp9wnRHO71?=
 =?iso-8859-1?Q?/earReXF2rF5pvTzUGkXfvbRGTk2Oo+oFag6THcJadO4rDLP6mfOJy8Cyp?=
 =?iso-8859-1?Q?fpwM/Sycjkw5BTvO8d7hqqwz1h3OqGtGzz3Dwoh4q31fRZAFcsNuZZA2AC?=
 =?iso-8859-1?Q?s3UgXQIkMheM+J+tTyiy6rjfNV74tWRBW75+nv2OYFJBLyq2PNdXR6LoUv?=
 =?iso-8859-1?Q?mvBZdc8700w0w7l3UZM5yQqLVrCOoZ2KCYh/QQ6gkdnZm3IbT+2MDWDOcm?=
 =?iso-8859-1?Q?sIodvrvfvgib4asqE9lkpFRLoUJV6Gk0Ez5j3p/3DZRFL7yOxbYBpYbL62?=
 =?iso-8859-1?Q?57FlhYoHGICG/9LGH8wMozUlaZTpVBWZrax0AdGYHTPrdlJH47jFhXq7nm?=
 =?iso-8859-1?Q?p2OdEtAsuTx1uV4hHteTgpSPGAl2QKk8yIoeWBRaTetq461ehclxb39uiU?=
 =?iso-8859-1?Q?VPu4w70WR8r7QtFMkSaz3U4byj0cvzngLrnHExjhLHACcbRSqQBLl6c0oI?=
 =?iso-8859-1?Q?4ZR1COCM/KoLXzKk7Bv52FEAkTd7NR6oKWBCBtvm0RoK2J+XmlxEMK1gpV?=
 =?iso-8859-1?Q?AEt1cmsY4RYOZci9B2YCP0ZK8jcNlJIU2Aw2566ny1m8JSmqfUc+cfl5M8?=
 =?iso-8859-1?Q?fNmzmrbnVicuqfd5hhnipwHFiUs8CfWiyrFCWB3jnCjXahZtHbCx3HVTka?=
 =?iso-8859-1?Q?iKOxSlWxk31hsTJytgpdh1Je4IU3a+joHrAYh16Xx1rspPZ/3zExi05Mm4?=
 =?iso-8859-1?Q?p2WkkpyZW4aVhnK5EM90v3RXoXOLOlx7VedAUxGE/6xmOdZ+JrsDWxhqyB?=
 =?iso-8859-1?Q?k2Kf4Zsh54layrupxDNt/HAlvpm51O8mcg59GFxLdq3u+W+wOKA5hhJzzM?=
 =?iso-8859-1?Q?oi4WtjU/r6s3C8DR2ffs/I9dkX5Ywx29CnENZ635GoLecdjpmeSHBYIvnu?=
 =?iso-8859-1?Q?fxEmQPl/2JWtngcUKMOxzgos8GBv/ZtC63Xkl1R8UzpdJGcCIzyDrhovaI?=
 =?iso-8859-1?Q?1OHsJmqfm5LVv2eRzhKCKCkvPar6IpQOQ32y/vrClME4KGZuUhotHCbyCV?=
 =?iso-8859-1?Q?dBrFgNQJesTkMBzYir+BzHN3V046PKXjPgq+sNGXSVmL4BRVWyw5261iGE?=
 =?iso-8859-1?Q?A8XY8/N279ROmw8Hm6QxBDoWxWWrlNXZ8CIK70g8Iqp4FqilYO2Djt3WZw?=
 =?iso-8859-1?Q?9d08ICBGfvseSqCnFLnP4YIC8tRdPCj1m9jNwsmPm3oTMCpZhQBmHMLxZa?=
 =?iso-8859-1?Q?yI0TTeTVfFetzUHVaRN8PctGIcLYwKcFel95fSPfYTJ/63hE9mvB7qCkoO?=
 =?iso-8859-1?Q?nU+IHRVCxMRfWGgO90frCO2ws81Sjbpapy23z/0DVfXsYxp4YEI0PNIc1a?=
 =?iso-8859-1?Q?7wFItm2DpkmS0i08dsVur6bsiLjC8x1jft2lrlmODeMe3zxclXb6q7FBHz?=
 =?iso-8859-1?Q?GMCkrYC5No/e8mLyFYhKUnh2H2ag2OjhOQX1EDOdQ88Zz+6qk77FzTrMRH?=
 =?iso-8859-1?Q?RZBU9vBO6PF2kxKsXa3LZBM1x0UNGwAJrAleiSGY19HHP4FPtCP0YgspDs?=
 =?iso-8859-1?Q?XmpOIhEEWOJyUiLodCKjUWXzWUdd0o7YoqifvlbtuMc8nRHG7C9J5XPZm7?=
 =?iso-8859-1?Q?SZFYa1sK5VLT6XgALCclmOlTPoSRpyEx3GXhhfysoADRqnZqT7VfslhWH9?=
 =?iso-8859-1?Q?BXp4U8zJ5oXY91LV34aZxUjQkf4jI3o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efae2cc0-7195-4196-eb14-08da370a1832
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 07:02:52.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPKgzDVG6qw4oLwtcb+SSSeNFmh6/i4rJ5teP6Ohe6QbqAPUpXNUVCKk+PKeJIZ3PUAIfl+wi2bqBqQfNgyDFM++2UWzscj+JNnbJn168Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9980
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
>=20
> Hello,
>=20
> On Tue, May 10, 2022 at 03:42:58PM +0100, Biju Das wrote:
> > Add device tree bindings for the General PWM Timer (GPT).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> assuming you will tackle my comments for patch 2/2 and will resend this
> patch along with a new version, I discard the dt patch from the queue (i.=
e.
> mark it as "not applicable" in patchwork).

Yes, I have incorporated most of the comments, only overflow issue pointed =
out by you and get_state callback is pending.
Once done I will post new version.

>=20
> Applying this one alone isn't that sensible.

OK.

Cheers,
Biju

>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
