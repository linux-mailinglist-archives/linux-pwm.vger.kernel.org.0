Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2401189C09
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCRMga (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 08:36:30 -0400
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:63886
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbgCRMga (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Mar 2020 08:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnkVDp0cranS13x9vx0ImGnweEP2XRuBkR1b54GMMs6+Aal9E7MrVhXZwWp2Vj5X7p/PTUQo0Y29belBg2FRCCxxyGachnG84TZ31oF4J/82lJnKIcfZZDK+rmcFa1hNtLh4q2Qh4dQ+NhedTb2+m5WngvC5rbR+59rGVNIOGa6BVGqV6++PPQsJvD3RhOIhq0XE8G4aCjS7qFxYRwhFTgsyqIdkGdH/IEW3FdSiXie/9qA+aM1eEMnkdbWu3syXeyR18oG+9w4+pJNJ4aCe+ZE9zLjdK357T9YM/sGNx25OxfKVE3sAUyP8PUcep6bsn48oIzmk/rWTRTX3lqSa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfaR8xnIj2No4mE7iXmIf/bT/msRRCNuKNNHsTJwLN8=;
 b=C/j1rcXZtDWRzg10Q97mGW1jWVqJr8F2vUg2Ej7RhVK/AaJ6Dl8ZwALdgIHM8XDOI9F6ccUmHW+LD6FrAvVNOWe/unayD5d5TCA5IKzhG0Jc4vgqnYcG2Zp/W0SGkTKjbK9QeyGYTIe2qkasp03GckUg9DxgHrZ9Hr0N9iyn//Cgv6PwwL2OLc6TWRtBKDwmrJb2NsQCL1mZREs4glVZaXPlA8kUXPI4pgAFZrWhy3imtJ4mXnpzX20+3TIUwc4qsEta8Y4ytsE7n7nt1JJGyjEpb/SbVoccsopL4Dk6ghQDFYR5s+bjVu7t3+N7ctiqpya/r975HKsNuiHtGSuKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfaR8xnIj2No4mE7iXmIf/bT/msRRCNuKNNHsTJwLN8=;
 b=ZKEMnjlAn0huyALiXowKhYoxrikdVjd5cSn88Tr4dOMSzfLd4s2TjmxqPVECe787x14vUkLsZiiea5hDeTKC1D3GX8y8tEtHGl1uca4oRX62zwoBFCPfcpFGu0mK8WUyCHgVWOuMUY+UWNn1qu7Jt++P0NFaO8E8GtuLbe9Dlv8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5264.eurprd05.prod.outlook.com (20.178.10.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.23; Wed, 18 Mar 2020 12:36:26 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:36:26 +0000
X-Gm-Message-State: ANhLgQ1D/694bD7j+qd8k/HNZxlQwSAzFpFwGajGA5qy09JNbRrDkUqz
        PRvgJX61g9ikqLTc14w1qL05OR9y8GvCHgcrZ/Y=
X-Google-Smtp-Source: ADFU+vtA9Wzqf115gD9yeh+Imk9vfSWfydMODrMw9vyWtzQz95+pbUx/kHpsa/63fKUL1LKlaQYs6hj83ryQcRK+SJU=
X-Received: by 2002:a05:620a:13c7:: with SMTP id g7mr3645869qkl.486.1584534981186;
 Wed, 18 Mar 2020 05:36:21 -0700 (PDT)
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-5-oleksandr.suvorov@toradex.com> <20200317230115.GM2527@pendragon.ideasonboard.com>
 <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com> <20200318122942.GA7833@pendragon.ideasonboard.com>
In-Reply-To: <20200318122942.GA7833@pendragon.ideasonboard.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Wed, 18 Mar 2020 14:36:10 +0200
X-Gmail-Original-Message-ID: <CAGgjyvG=eqTUP0c3rnRq7vm7wZk-95oEtVEhV9GCBohC6sBcRg@mail.gmail.com>
Message-ID: <CAGgjyvG=eqTUP0c3rnRq7vm7wZk-95oEtVEhV9GCBohC6sBcRg@mail.gmail.com>
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
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f173.google.com (209.85.222.173) by MN2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 12:36:25 +0000
Received: by mail-qk1-f173.google.com with SMTP id e11so38258752qkg.9;        Wed, 18 Mar 2020 05:36:25 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1D/694bD7j+qd8k/HNZxlQwSAzFpFwGajGA5qy09JNbRrDkUqz
        PRvgJX61g9ikqLTc14w1qL05OR9y8GvCHgcrZ/Y=
X-Google-Smtp-Source: ADFU+vtA9Wzqf115gD9yeh+Imk9vfSWfydMODrMw9vyWtzQz95+pbUx/kHpsa/63fKUL1LKlaQYs6hj83ryQcRK+SJU=
X-Received: by 2002:a05:620a:13c7:: with SMTP id
 g7mr3645869qkl.486.1584534981186; Wed, 18 Mar 2020 05:36:21 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvG=eqTUP0c3rnRq7vm7wZk-95oEtVEhV9GCBohC6sBcRg@mail.gmail.com>
X-Originating-IP: [209.85.222.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d467322-1cb9-459f-a4e2-08d7cb38f92b
X-MS-TrafficTypeDiagnostic: VI1PR05MB5264:
X-Microsoft-Antispam-PRVS: <VI1PR05MB52649D863E708CC510375FDAF9F70@VI1PR05MB5264.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(4326008)(450100002)(9686003)(86362001)(6666004)(498600001)(6862004)(55446002)(26005)(186003)(44832011)(66556008)(66476007)(66946007)(42186006)(54906003)(81166006)(8676002)(8936002)(52116002)(5660300002)(81156014)(53546011)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5264;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQcTJIMpOV7LZesj4a+Qk97+KZZXWCgofejw3CO429d+UTPebMjDCrtfzEXWSBmpnePjPLSx7xBURVqSjPo5Cv+Asq/rXTL97zuZl1obRzjuCpLDa9Ap4Fovw9E7cH0k9g8Ajhdt5DcBLCTMVRy2MwYAYtK7pGBkpfXtCHspXjSUKvHCc67ZzzJWcLkB0420KLyyzZSXY78ON/dayCqjEAFObHmy5+WH4aj7AsmBztWbHtEt3nmH3V1bNBQPn7+DRde+8x2CRmYQfG+erPy1maOiEO7vSP++T7H/JU++rLrtm9pf07DiekRXJt/BFU7bisIEmz2rc9bamPNvrAt1By3i1jtfYXoHLfjXOdHyCCxQ99LQp81B6cT+JW1Pg6JJ3e71QKbPt7hXW8odfpbwtjVGmhAaX7f7vzabTLAKaruoty4jxtuFDs6hc3EoAwTA
X-MS-Exchange-AntiSpam-MessageData: NkkIUWUvjRxuqVaBeTKXFfcWLOQ9UX+wrD+7NJ6FUO/QGQOB8T5/JbI185JpHxiMqkzFOQ6v+L4wdKXP4LDI11yRw6e5VCPlNKjOProl/mc9OFXo0n3Ovi7it2BcTVwVFMB3hU4Wy/mR0HJhN6p5sg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d467322-1cb9-459f-a4e2-08d7cb38f92b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 12:36:25.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5iMYOEjUNxVjWEmV9jHpn//KZ+UJshxKsrUgmPGlGcLLbu2M58tyMa0ZoNeTrto+5KlnB5dNLdq58EfqhfWabENwsAtIjZAgq/Z2Y99CN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5264
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 2:30 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Oleksandr,
>
> On Wed, Mar 18, 2020 at 01:37:00PM +0200, Oleksandr Suvorov wrote:
> > On Wed, Mar 18, 2020 at 1:02 AM Laurent Pinchart wrote:
> > > On Tue, Mar 17, 2020 at 02:32:28PM +0200, Oleksandr Suvorov wrote:
> > > > Move the description of the PWM signal polarity from
> > > > <linux/pwm.h>, prepare for removing the polarity
> > > > definition from <linux/pwm.h>.
> > > >
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > > > ---
> > > >
> > > >  include/dt-bindings/pwm/pwm.h | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> > > > index 6b58caa6385e..c07da2088a61 100644
> > > > --- a/include/dt-bindings/pwm/pwm.h
> > > > +++ b/include/dt-bindings/pwm/pwm.h
> > > > @@ -10,7 +10,16 @@
> > > >  #ifndef _DT_BINDINGS_PWM_PWM_H
> > > >  #define _DT_BINDINGS_PWM_PWM_H
> > > >
> > > > +/**
> > > > + * a high signal for the duration of the duty-cycle, followed by a low signal
> > > > + * for the remainder of the pulse period.
> > > > + */
> > >
> > > Last time I checked, kernedoc didn't support documenting macros (enums
> > > are supported).
> >
> > That's why I dropped the kerneldoc tags leaving the descriptions only.
>
> But you forgot to replace /** with /* :-) Sorry for not being clear
> about what I meant.

Ah, yes, thanks! I'll fix it in the next version :)

>
> > > >  #define PWM_POLARITY_NORMAL                  0
> > > > +
> > > > +/**
> > > > + * a low signal for the duration of the duty-cycle, followed by a high signal
> > > > + * for the remainder of the pulse period.
> > > > + */
> > > >  #define PWM_POLARITY_INVERTED                        (1 << 0)
> > > >
> > > >  #endif
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
