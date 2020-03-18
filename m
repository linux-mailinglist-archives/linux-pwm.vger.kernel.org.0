Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2B189ACE
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 12:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRLh4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 07:37:56 -0400
Received: from mail-db8eur05on2109.outbound.protection.outlook.com ([40.107.20.109]:54880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbgCRLh4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Mar 2020 07:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhIoch63e/WAdWEi0ts8UZoMX+k72AcEPHFpRRlFZF5uRUz6N0Y8WJ+GGVwfWTxXK8MOKQZMfbxqJq8UOwN8ZbvCnsvESM7oF8qm0bcSkHTI5oPxbSnSE8G5XZrrZtXfGyBU8LMQFjowAr08D5O0ogRonzTiWNw9nitvOepdMGMcJIL1pfmuWP39Oad5h7eVwyEv5nz7RZxkhXiTOeZUc80MayzC5lcBuoMTxq18foBqSGvDcvzT67KdFOHmlsiHicaEJPV8H9lq2r4kazDe6DlpUTRx0QVrTzsFMkQ1+YHI3uKtyIrylYHKyNlKkx89QEoh4wd+i78cjXSchwAN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxwTF5BUMkIh39kJR3+9eCrOSkdEZtC/Y5UTBIULKQc=;
 b=k8/qxT55ismSNjz/+2/Hz3FPYvTUWhKl0kMF1jDOTfG7AqFx28Io21856oSxKwMHzpvWSckL5bhuqoBalL6U316dNtilgGm33n6VdPm7yEP5TItOb2tpgwRhUdV/Ps1PonFCylzf0OA0ftJcbngHouPvk6QvIP/FToZaErxG2PXfQbnHeBkdxm38U1Vkov1ZXw5xzLZ9ZFSdAWzBn3xwgR2lhtcxc3/3pzT8zzAcz0HKwpyKLz6WEAL3R7cEjwpWC8J6/RhjTXPoeetYWET01ED/gecbaz6Wc8zyGEXpX6NJ6Hnd7AG0QwP4Je7C6RIrjpvAnZkEm2ouXU+Fxrq+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxwTF5BUMkIh39kJR3+9eCrOSkdEZtC/Y5UTBIULKQc=;
 b=MRcd1aGq99rz7bF/46BFkLLFNivT6EBs4Ot8WKHG0ZpTef/QulRbT+0pdNqxyLc2nFvWFY0W/uTS2k0Or+00GjoY62MA+MK3emhsEOORT7Fzme6lMDG1p0rWYF1xfngDz2mmJkO7j2CN+ZVemXK6XG5faOppOJysTdEhLquM3ng=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6493.eurprd05.prod.outlook.com (20.179.25.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Wed, 18 Mar 2020 11:37:15 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 11:37:15 +0000
X-Gm-Message-State: ANhLgQ1iEP6of7LUhN0elNhib0QOdOCQwFhgBLzXdLCDSPS9hVy5LFqC
        8aWDsmLfXVmhpnE6fXlC1cqX4w0W24AXUTCn4+s=
X-Google-Smtp-Source: ADFU+vuGXLzGDmoWa0HHKzUwu6x5I91KzQ6WZwRI4nrYXhp5JN2rwL3YkKtGFHjJ/LcWYeaszBJ+6n1Ycnb4P30pQLk=
X-Received: by 2002:ad4:4e10:: with SMTP id dl16mr3840515qvb.44.1584531431943;
 Wed, 18 Mar 2020 04:37:11 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-5-oleksandr.suvorov@toradex.com> <20200317230115.GM2527@pendragon.ideasonboard.com>
In-Reply-To: <20200317230115.GM2527@pendragon.ideasonboard.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Wed, 18 Mar 2020 13:37:00 +0200
X-Gmail-Original-Message-ID: <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com>
Message-ID: <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f54.google.com (209.85.219.54) by MN2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:208:23c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22 via Frontend Transport; Wed, 18 Mar 2020 11:37:15 +0000
Received: by mail-qv1-f54.google.com with SMTP id cy12so6743996qvb.7;        Wed, 18 Mar 2020 04:37:15 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1iEP6of7LUhN0elNhib0QOdOCQwFhgBLzXdLCDSPS9hVy5LFqC
        8aWDsmLfXVmhpnE6fXlC1cqX4w0W24AXUTCn4+s=
X-Google-Smtp-Source: ADFU+vuGXLzGDmoWa0HHKzUwu6x5I91KzQ6WZwRI4nrYXhp5JN2rwL3YkKtGFHjJ/LcWYeaszBJ+6n1Ycnb4P30pQLk=
X-Received: by 2002:ad4:4e10:: with SMTP id dl16mr3840515qvb.44.1584531431943;
 Wed, 18 Mar 2020 04:37:11 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com>
X-Originating-IP: [209.85.219.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac37f86f-3b87-4102-5a97-08d7cb30b50b
X-MS-TrafficTypeDiagnostic: VI1PR05MB6493:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6493C9C9F423B4F563F89D99F9F70@VI1PR05MB6493.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(199004)(52116002)(9686003)(44832011)(55446002)(450100002)(5660300002)(186003)(26005)(55236004)(2906002)(42186006)(6666004)(4326008)(54906003)(6862004)(53546011)(316002)(81156014)(81166006)(8676002)(66556008)(8936002)(66946007)(66476007)(86362001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6493;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOYJh5/+FoT85ILJE/erSf+vUeNr/4lhaFMnspidW2SSU68D1B90glkSnFQRk6g/V+3ZakEX0yYaF2olxFgAePE3zvBAIO5uYjVYRSqM2EfQly2BIO3tZBYbEcxrmPpFAUmZ3tBUuGOXJOxBMyRIq0PSLOjLJUfYxR5b2I+5W+9YxcDNdBr0XsXuYtMuOj9DYFGZGdwQgQpzts3q0sihkmZkxNCPmDr/aSpjsfUTDs/9Y7p+ALobdohRMDJJzS934Bskg48gqEKIH2n8HYuZ49qB9p8ppMrXvfUjS5CxZhZzeYqbGc5RcGjRR/ycP9u7aVA896gU8OO3Wa6zx2zKHRijtr0C0UdNWAHEzYRFFpnHMmy8PRALaEJ+kaJ+JFZRI7ZTzktiBvHdFFkrQgCfydS9Upb1DHmf4hv8KuinLFWrdACIr461+vqKng72ELNX
X-MS-Exchange-AntiSpam-MessageData: PucYqdzj5+JFRR5fUB212zRl1fljno6Kn1ggxn5lSNotHSgDZWX62BNwNd2EY53DLn9OOfDdMCn3GtlJdqFJcw5NPIE20lHLwnNFXrWw1Rs6sdKpfrzcJSkSJadOYMokpy/4TVSfSNBEQCuRFVoXmA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac37f86f-3b87-4102-5a97-08d7cb30b50b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 11:37:15.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rP4LQJUlMP1b6usNMMheJKBu11e+mrs1hFHMpcWbHTrRgY5m48pyaea21qHwSTPHBw/PaQa07uBXi3VETp+4UVtZP7ji0ym50A0tzKKcrjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6493
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 1:02 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Oleksandr,
>
> Thank you for the patch.
>
> On Tue, Mar 17, 2020 at 02:32:28PM +0200, Oleksandr Suvorov wrote:
> > Move the description of the PWM signal polarity from
> > <linux/pwm.h>, prepare for removing the polarity
> > definition from <linux/pwm.h>.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > ---
> >
> >  include/dt-bindings/pwm/pwm.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> > index 6b58caa6385e..c07da2088a61 100644
> > --- a/include/dt-bindings/pwm/pwm.h
> > +++ b/include/dt-bindings/pwm/pwm.h
> > @@ -10,7 +10,16 @@
> >  #ifndef _DT_BINDINGS_PWM_PWM_H
> >  #define _DT_BINDINGS_PWM_PWM_H
> >
> > +/**
> > + * a high signal for the duration of the duty-cycle, followed by a low signal
> > + * for the remainder of the pulse period.
> > + */
>
> Last time I checked, kernedoc didn't support documenting macros (enums
> are supported).

That's why I dropped the kerneldoc tags leaving the descriptions only.

> >  #define PWM_POLARITY_NORMAL                  0
> > +
> > +/**
> > + * a low signal for the duration of the duty-cycle, followed by a high signal
> > + * for the remainder of the pulse period.
> > + */
> >  #define PWM_POLARITY_INVERTED                        (1 << 0)
> >
> >  #endif
>
> --
> Regards,
>
> Laurent Pinchart

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
