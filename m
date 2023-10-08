Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CF7BCCDC
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Oct 2023 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjJHHC7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Oct 2023 03:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjJHHC5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Oct 2023 03:02:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A98E4;
        Sun,  8 Oct 2023 00:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK2MpNJN61tM92TlLn4/nDMw7oqFHwa+cx2BZYQuTscxmN31MtXrIKVTOoGBaf9KvQInigYphkPKbJgkFKQlgfpNR0+d3QC0iuTpMFC2DNOW9xqhoSx+J30BO2M8WMXfGL6TaUBVgZsKDRMbg5g1vDUXI0sJ6RXs+hRULBgx25E9lvtKpCnb/QozFkDjGtr/Y4I220Z9lN869x0m7v5d1xIfduPZmYIKTa64TZPl5gB5pnN3AISIN48mt7omPiuiiOfXOZN8jBzmwChz006DwJqSSCVv5HKyVlIcq3mrFneVXnyPwbwZnQnq1OMFKRGR/GJyRdqRcXnju0fyr/FWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8+JL+nGd+Xpr6M4ccY9+pkQpUtmfMd+bnxNMUMAQdw=;
 b=Z7MRow3Nopjx8IVB+quZoUN9IBKQEqROdK9f19KxsaoF7GtVgEa8ql2qVuqRY1q2Xae51ZZMIMtiM4ezO+dJHMX5CxUfiNeifF/XzaXAhqaUNwT3UW8ts55ucf4Zib995gI7ecPIwtlbiixxnOFQjW/QhZJIz6drCDuk8sTGq++rurEhJZ33mISRPRYw/+1SOuT/6W4xSXQiifkiQU1k/M+AJNAT7AMD334apkxXegBungELkFM8nYmMUt560inSduzX3rYVzuPcRH/kJWW7i/dk3pKMshUbhNLpeo9YTwfbJpj7GY5hjo9AHfK1Kxp3MhGc2lcFlE2gtEt4QRd/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8+JL+nGd+Xpr6M4ccY9+pkQpUtmfMd+bnxNMUMAQdw=;
 b=G4zMQTrD+HgwYUQa88Czoed3hLfETkfNDnA+ZR9G/HGAPiYNgEi6mhu5EcNLHkPdi8mBtFBrf5lgmNp/vm/oRgKKz5h80rpVyBJ7rU8p7XaYfvfezSuyDHjO0eo/krXGFgy9YKAUGyBV9/qFgbNI2ygLyPN+qUIoHkFEiDTyNQs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB11153.jpnprd01.prod.outlook.com (2603:1096:400:36b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sun, 8 Oct
 2023 07:02:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 07:02:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZ9rQMFWDsgVRgWEOut3JS4AjEP7A7XDAAgAQghOA=
Date:   Sun, 8 Oct 2023 07:02:46 +0000
Message-ID: <OS0PR01MB592277821DE821BD223E922686CFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
 <202310052353.flpqN2Di-lkp@intel.com>
In-Reply-To: <202310052353.flpqN2Di-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB11153:EE_
x-ms-office365-filtering-correlation-id: 561d804b-315c-4bc5-e1d9-08dbc7cc93aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2j6nYikJsGUgtJrxjzi1I02cMOTUgbVMAad+6lJV4iajzrUcFsfzqkGA/grO0+HioQPVSTH65/G5lffCy+SCrFlSVGOr1Fnm2kFHLFugGx0Xe8g2WGPuZHdV+3gffzcwRUVTuGqtgLZGE2/i0MXuwIPO93EGVcKvpN0QVI/IU+ChoPAmQ4kGRbGEABYpsjwjkh0PFnHrxDhv6DZdX2Oxv5GH/TE7Rmi0TCu6B1a1l14fbLpzCTAsLTfskUf+vmnAj/JocQdtGMVu5ItG2QhyZG3/oBuWZE78lPqt7430NNw4NxJrfDoYhLJexEBnZLnsgWalLGzdg8DzuisCm9ax+lVcxmuMQXwwekRaKLuaOebDGWzBRlTfciDY7+P6DCk1yRL3PdrXxkjhLupBrPEH6hcZjiVjduuIOxoBpMW2GMm7cU3BDeUMMka75HGUQ+Tckl63hG9Cnq7RTVGwltG7W1U2+irQletEttCqenCbjqqN1QazYdvjO2BPbAyFuOqtPZBryeWoQJhTaCDUXGqYh2tk848ok1jDS6BqRVKmC/5OJVgb2YydZJCewChiZoj3LszO1WNLNNPiXwZJmGdF3SThqwtqGycGmwOU42cZqiIJHpaQ1G2XWMx0LRoC5ZW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(83380400001)(107886003)(26005)(66556008)(66476007)(64756008)(66946007)(76116006)(54906003)(110136005)(316002)(66446008)(6506007)(8936002)(4326008)(8676002)(52536014)(5660300002)(41300700001)(7696005)(71200400001)(9686003)(2906002)(478600001)(33656002)(38070700005)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RgPH3gNd87U7kC8XdZZFvXOTvWqhZ2eGufplrs4+zWySB6qsNnoq8ifqTk?=
 =?iso-8859-1?Q?KnA9fU0AfRqCBR2r7uKX+K9MgL2wSlE2WvcfKgPpieg3E6txZdHyaG6V76?=
 =?iso-8859-1?Q?lTIU/f6DzjSFSoeMqq25obKJv8ZGZnRPJlEGjrbK8z1FcMpESMAOU73bsF?=
 =?iso-8859-1?Q?mDv0HKwMw8x5ceAZU54iwfeztisBX6i2HWQIPbR0Yw5yQcCnPryRpxE8Jm?=
 =?iso-8859-1?Q?Irmmh8jjBrAY9KIdv82JirVhUD8vt00j+Cs5BYHI5SjSIeoImDofSGV53V?=
 =?iso-8859-1?Q?eRgM5uALHqKFxFFMbgRRUWfbG4EYGlBjckVEwSVBahVqoZ3vu8gwwBrmHn?=
 =?iso-8859-1?Q?T0GiCmUH2IJ8aZexQiW7ZJWURC/2MPAfNZwUzmXSvYlailh8rLokIOvQn8?=
 =?iso-8859-1?Q?4It3cPUB2pHxa9fVtZoaPLVvv0nrN9mBFtMyi+eNUrGPxndEDsL58hbOwG?=
 =?iso-8859-1?Q?L4Jcd+4NlYWF3ckrUREqEfOXqKJ7YF78ieBlJsqO9GvLyDoic9Z6oDHswB?=
 =?iso-8859-1?Q?n/S7KCSqDaQvM6jEVaWZBH7vzj42RA1yV9ythHBle+4bCj+ighUmCN6vyy?=
 =?iso-8859-1?Q?wDC9TPtzji+ruL1FD/5e5kaaH4weI9nuMcQfi3AmTWr4A/c7pdfWIUx7fv?=
 =?iso-8859-1?Q?f++ocx86Ag+XHoxiGOQ2h67ygpaoC1JL0iikWgZAyhQRJXilGouWpIuNSH?=
 =?iso-8859-1?Q?lX82GvqwZxJrIaNNYdsEmdOGIiT94CPnKkff7TRRGF7LhTGK0ciDMd7erb?=
 =?iso-8859-1?Q?wTcyNsR+peLw9OOsosDVMlsr82H9VsdMV5909vhZLQNJVZvfA3qOMJmchc?=
 =?iso-8859-1?Q?bNw32zpnHVHOfYGHJaCVx1WbSgBzO8GchrfKOjxr1ynVSYiUWdUiyz7xpe?=
 =?iso-8859-1?Q?uFywSICjxw/dESFTPXfIAdLuI0ZrgColx00sMLH9tmOpqnTC7tJGxQ3VlN?=
 =?iso-8859-1?Q?+P7OBwdb8ABL7dzbNWRLgzRPk2+HI/ve3ThfacWTNdjJ9KS/9N2m3ilz1B?=
 =?iso-8859-1?Q?cyOWOeiDjb2dkAiRht4mx2+QBoo5YNSF4o3+9ha0sKqRlfZb1CaTcCpWkK?=
 =?iso-8859-1?Q?8So2iz95j2O7OKIukL22deQHPOEksFfJi7TTQdaZ2lFA+yMVi4hJQd51Z8?=
 =?iso-8859-1?Q?KH5CynzHwEfCQjcNSzCW6iTzRBX4R2fxm0re2haNeqFWc/sik4Kc6hm2d+?=
 =?iso-8859-1?Q?ed2Yp+iszs5oVfwOldgpUg2wlgiFHIdYTAD4ny51Fy8Sfz2UOxyK6de+it?=
 =?iso-8859-1?Q?kZU2jwvtaBLiiuTHLXxJ9I8KF8wdyvjmZf/pSnjpxtSQCafGAXiwHhmqHt?=
 =?iso-8859-1?Q?yPbcNhEtPJt/2EWVAJ9gFHPcCh6m1x+X9Ln2sREnXVHCoRu4jwJU1FqLzJ?=
 =?iso-8859-1?Q?cx9YPOtSdx2C9LwlOmbcBZBiGr6K5184l48WTMDu3v1QtGCrWfTsPoVc3v?=
 =?iso-8859-1?Q?S8DxTMHrjLrq5xo19IesOW9Lw5aqyMilgZ06OYC+D6ky8xE1MgszU4tXjK?=
 =?iso-8859-1?Q?KuBNYHZVE8WUqDl7c/9kEebJHS/lWK3HN9JG+9nbQcEY+9vYJPUQ8s0KWt?=
 =?iso-8859-1?Q?MQgxS3XSMT0d6VFdUOj3cFASS8LAL2aLk+UFfpKdoXvxtaxbTcpBk64o9c?=
 =?iso-8859-1?Q?mMRkMQsRcmmHhEk/6YIUqc2l8E/mXIeD3ZdquTwqIil2L8ePEPel2yNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561d804b-315c-4bc5-e1d9-08dbc7cc93aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 07:02:46.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NfLPlDnJDGGkPSJdUP9PyJ+7U7QgfelXs7tsyAOpKEraOb5wOuPa2z36TRmNeWrtjiynheVA2ytJQYjv87ZeBIr2uQgvU/exKDzzjx5NGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11153
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Kernel test robot,

> Subject: Re: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Biju,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 4aae44f65827f0213a7361cf9c32cfe06114473f]
> base:   4aae44f65827f0213a7361cf9c32cfe06114473f
> patch link:
> patch subject: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
> config: arm-allyesconfig
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0 reproduce (this is a W=3D1
> build):
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
>=20
> All errors (new ones prefixed by >>):
>=20
>    arm-linux-gnueabi-ld: drivers/pwm/pwm-rzg2l-gpt.o: in function
> `rzg2l_gpt_config':
> >> pwm-rzg2l-gpt.c:(.text+0xae8): undefined reference to `__aeabi_uldivmo=
d'
> >> arm-linux-gnueabi-ld: pwm-rzg2l-gpt.c:(.text+0xb50): undefined referen=
ce
> to `__aeabi_uldivmod'

I can reproduce this with Ubutu-23.04 and the instructions mentioned above.

This issue is fixed by replacing
DIV_ROUND_UP()->DIV64_U64_ROUND_UP().

Cheers,
Biju
