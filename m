Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB51A0C44
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGKwO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Apr 2020 06:52:14 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com ([40.107.5.104]:4018
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728290AbgDGKwO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 7 Apr 2020 06:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPvKPDODVx3btLyr6nCAx2AvVoxlM13id6JB+2Fl1xZ/1c8whdD5tHO9HHA2cM3MoEueq5OYsJ33i1slyrriXPZtz2F65NvxD7rWebx4CkX+PbR2kZZubHbjy1fjBrZ4s9joatEc64U+Ajf2SwcvQXlJVu6SebsB6ShbPg90iGF3IP5C0rrPWJRHtqou2mriPbiVflE8MeIAlM+QTpscC1HAe8zjML8Cv8o+kgpIdCFnMLyVuDVB5GwEFxyGMl95ZIcgR5mIamkxQBUTgzdLJzakQ8d3pAxlq0IQWKsN0pETWvIYvmHNu0FInanHWE8/mcBIU7I12yu7NdL3HOKEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhiOeoD8Ep3vd7ozP0ztEl47UdSzPh4C42RP3wdk7Yo=;
 b=C/BVUI01yoYinjLvHcUyJqQDgL5ovzTRnlOduQ0SehoUo16NkKRSHZggwoSNS7fano440j/wnlF2bWmKYabaYrDDyzU97hKAdtk3xnSIlpgwSJMhblFOGC7IJGv9uzeNsnTfwiZfvntsXEwAhy4PuKqNRszasRI16BmOopYv+zEy5b4jRnsFRnNfYN3BOkSFshJbvKIel7uVuT3pAfFQT0cvdzsd+pmyOBYS0gmG1FYLJd52Ce1mZ0qykUViss5ybULLXyZjGTbmUuhN37ifmOdKJ+pKpTuOgbB16g5sDd9DiDJoXg8oY7mC+iL1GDyXIEzVqvVEO88naBd+JyZC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhiOeoD8Ep3vd7ozP0ztEl47UdSzPh4C42RP3wdk7Yo=;
 b=HOXOhS+ug1U/EFc2nempusn+TMyRtbjbsrJblupYTVWFVMKqWhD8U4isTst13dem2DRGpOG4/mvMeKTtUUEYacPpSvxwAtL4/+5C6AvEkEcBsFQhhhStsMtE5Ag2Dt0V5bIrfpyPxoS/ehYSpZ6ykD1VeafyKdOXTX9LW6561F8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB5888.eurprd05.prod.outlook.com (2603:10a6:803:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 10:51:57 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 10:51:57 +0000
X-Gm-Message-State: AGi0PuboX5G7pHioKwFTVEiVxK2/Szv7Y5uX0vfz3Fsn6c7l6St7IfrC
        QnR3VlLggZ+A0E8KBRfim4drngjWv2WGJ3pdpxo=
X-Google-Smtp-Source: APiQypJcJNgpNCHWqde1ppPh+KOdbTYRa6VL+4ueqjtQLTpEjbjBgjlDMjA9dAs6ilFY8udrPh9G9EFK+lyL21dP3GM=
X-Received: by 2002:aed:2351:: with SMTP id i17mr1528151qtc.342.1586256713855;
 Tue, 07 Apr 2020 03:51:53 -0700 (PDT)
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
 <20200405192246.3741784-3-oleksandr.suvorov@toradex.com> <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
In-Reply-To: <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Tue, 7 Apr 2020 13:51:42 +0300
X-Gmail-Original-Message-ID: <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
Message-ID: <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qt1-f176.google.com (209.85.160.176) by BL0PR01CA0021.prod.exchangelabs.com (2603:10b6:208:71::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend Transport; Tue, 7 Apr 2020 10:51:57 +0000
Received: by mail-qt1-f176.google.com with SMTP id n17so2268060qtv.4;        Tue, 07 Apr 2020 03:51:57 -0700 (PDT)
X-Gm-Message-State: AGi0PuboX5G7pHioKwFTVEiVxK2/Szv7Y5uX0vfz3Fsn6c7l6St7IfrC
        QnR3VlLggZ+A0E8KBRfim4drngjWv2WGJ3pdpxo=
X-Google-Smtp-Source: APiQypJcJNgpNCHWqde1ppPh+KOdbTYRa6VL+4ueqjtQLTpEjbjBgjlDMjA9dAs6ilFY8udrPh9G9EFK+lyL21dP3GM=
X-Received: by 2002:aed:2351:: with SMTP id i17mr1528151qtc.342.1586256713855;
 Tue, 07 Apr 2020 03:51:53 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
X-Originating-IP: [209.85.160.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa8d418-4f9f-4baa-628f-08d7dae1b14e
X-MS-TrafficTypeDiagnostic: VI1PR05MB5888:
X-Microsoft-Antispam-PRVS: <VI1PR05MB58880063227F559576F81B0DF9C30@VI1PR05MB5888.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39840400004)(346002)(136003)(366004)(376002)(396003)(8676002)(81156014)(86362001)(8936002)(81166006)(450100002)(66556008)(4326008)(316002)(66476007)(6862004)(4744005)(186003)(66946007)(52116002)(966005)(26005)(44832011)(54906003)(9686003)(55236004)(5660300002)(53546011)(55446002)(478600001)(6666004)(2906002)(42186006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewO5136rLVVos6aDUu0GO4GSULr0HZO/tmyfN+OF9gTra7nCtNzG5ZXkHSMaiEFVlFK17V/37MwXq+m86Ob7QOTQ3SSKu38J3qA4vTwRCyRsSuVypIqFTpdSHMF8CfTFj5xbMCIv9cNJRULMk+xFOFiwjzaG9APFHCc2OsJIMTufSHrZZ47BZEIrHciyWlceHIjHmDgIc3x8piJM7K9oG9L7ir5O59mdbxWZEeWs8pxUHXGPWbjOZphtFccAT1lYh6GFkJaj61F9/1td4YyxHQRRbGEaPnyELOuoGyTPQTEtT17TjJU2DJOIZTBfUCXQSSE7ipFvKkt931u5IHc7FY4wIyTX7ZwZTxujuTjJLCmcmqMrua8r8iqlSf74Zu1/pBHZRnUs7yON0ys71JDL0TvjsFCjsLYmvMUTFkIHT1WQT8j0Tx4HLhQ0GE/7Afl8SnUK7Jc+talrbcOrEnjC3v4oYamINUB9QJ72SMhQkg7anX7a6CL3/Ult/MaOW/FNgKlhIYnmrEbUVPF4OgJNog==
X-MS-Exchange-AntiSpam-MessageData: DACH9GMOzmaYoz7Op35kZoMXQaetfc92bMgq6Z2n7ZLNMJQCiYQc/Cj0XCUnM9pBOqdKjBeF55L92rYiGs86Zxqdp4eorzASxC1ZVTMf8wLwgML5DW6M8hSDXL9LQHP9QHLE1dJiNNgt0HNLuGtd/w==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa8d418-4f9f-4baa-628f-08d7dae1b14e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 10:51:57.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIU7qU7SARTTUvStQ9cXOrpuL7cKO+au53bX/utZsbEVdUCXrRkIY0c0IBqcz7ZhIwZZZ2fTz6Jb6y+dji71ofR7ohtZsQ6hDhl6FBJsWqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5888
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 7, 2020 at 9:17 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Sun, Apr 05, 2020 at 10:22:42PM +0300, Oleksandr Suvorov wrote:
> > Add the description of PWM_NOFLAGS flag property.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> As I already wrote in reply to the v1 series I'd prefer a name for 0
> that explicitly handles normal polarity.

Uwe, AFAIU, there is no flag that forces normal polarity, the normal polari=
ty
is the default state if there is no flag to invert the polarity is set.
'0' value in the bit flags cell really means there are no flags set
for the PWM instance.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|



--
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
