Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B24F494
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2019 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFVJEp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Jun 2019 05:04:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43267 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVJEo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Jun 2019 05:04:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so6333877oif.10;
        Sat, 22 Jun 2019 02:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znnrmmd5ezgQQoLVi1c3W8tP7JtD4QP2MPjjSsJDXVU=;
        b=J4puKHaedbCVC0VPDEv6DPwzuVD/6NLYgQURAXaVuj9/aPGV3lcvz2L/JpGMRehaOE
         JzTqLFh4UVgXb2MSxJVFHy9+c8EsQdYqBrBfK3rbxgxIleboENJL+oL/ITOdXOhEtGzD
         ZoLbSd5r7rJAzhqSDEmjcjBwwg5qPvC5yXSSxXdrEpz9QhjfqagRtUEqxudBFS54drle
         vAic2Pv6HFtm/PDTOOhqVuqejUYs4fV3knL9SJpnVTCmKFO1ALGHX+F+96ua/+J8qm87
         4C20oW/e6ZZMGz0ZfLtEZMoPQoTDi/3JDvcUrh9sMSAWoZIvmMt2KBKH61Ux4NXs9M4G
         vcFQ==
X-Gm-Message-State: APjAAAX/xEGXxiPNboakoJnifA3ebMXmN+YfdEMGNOE4FymakXBCLU0w
        K5Xb7y5cmoOAzc7qpgmdMT/L1QnC7jQ/pJrZXxU=
X-Google-Smtp-Source: APXvYqyrO8swJV7vX2S8SGUP+QsEI2mkcYtZ8Pxi8Q9z7YEX829B2FvfF+OUbjnxitwSAZE78Re+Rc1Pt8gdkXlN8ks=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr5281987oib.57.1561194283551;
 Sat, 22 Jun 2019 02:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906170746150.12344@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906191123400.34742@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FC28D@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906200843320.9673@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1906200843320.9673@fox.voss.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 22 Jun 2019 11:04:32 +0200
Message-ID: <CAJZ5v0gtG5mcBwMB7mZ2aooBnJmL7fmx=QpoeMTDpbbHrue6OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table loads
To:     Nikolaus Voss <nv@vosn.de>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jun 20, 2019 at 8:49 AM Nikolaus Voss <nv@vosn.de> wrote:
>
> On Wed, 19 Jun 2019, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Nikolaus Voss [mailto:nv@vosn.de]
> >> Sent: Wednesday, June 19, 2019 2:31 AM
> >> To: Moore, Robert <robert.moore@intel.com>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J. Wysocki
> >> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Schmauss, Erik
> >> <erik.schmauss@intel.com>; Jacek Anaszewski
> >> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> >> <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI Devel
> >> Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT
> >> ARCHITECTURE (ACPICA) <devel@acpica.org>; linux-leds@vger.kernel.org;
> >> Linux PWM List <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> >> <linux-kernel@vger.kernel.org>; nikolaus.voss@loewensteinmedical.de
> >> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> >> loads
> >>
> >> Hi Bob,
> >>
> >> On Tue, 18 Jun 2019, Moore, Robert wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Moore, Robert
> >>>> Sent: Tuesday, June 18, 2019 1:25 PM
> >>>> To: 'Nikolaus Voss' <nv@vosn.de>
> >>>> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> >>>> <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
> >>>> <erik.schmauss@intel.com>; 'Jacek Anaszewski'
> >>>> <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
> >>>> Murphy' <dmurphy@ti.com>; 'Thierry Reding'
> >>>> <thierry.reding@gmail.com>; 'ACPI Devel Maling List'
> >>>> <linux-acpi@vger.kernel.org>; 'open list:ACPI COMPONENT ARCHITECTURE
> >>>> (ACPICA)' <devel@acpica.org>; 'linux- leds@vger.kernel.org' <linux-
> >> leds@vger.kernel.org>; 'Linux PWM List'
> >>>> <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> >>>> kernel@vger.kernel.org>
> >>>> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >>>> table loads
> >>>>
> >>>> If it is in fact the AcpiLoadTable interface that is incorrect, that
> >>>> of course is different. I'll check that out next.
> >>>>
> >>> [Moore, Robert]
> >>>
> >>> Yes, this is the issue, not specifically the Load() operator, but the
> >>> AcpiLoadTable interface only.
> >>
> >> thanks for checking this out. So what is the conclusion? Is my fix of
> >> AcpiLoadTable() sufficient or do we need a different solution?
> >>
> >> Niko
> >>
> >
> >
> > Your change is in the correct area. We want to do something like this, however:
> >
> > diff --git a/source/components/executer/exconfig.c b/source/components/executer/exconfig.c
> > index 84a058ada..eba1a6d28 100644
> > --- a/source/components/executer/exconfig.c
> > +++ b/source/components/executer/exconfig.c
> > @@ -342,10 +342,9 @@ AcpiExLoadTableOp (
> >         return_ACPI_STATUS (Status);
> >     }
> >
> > -    /* Complete the initialization/resolution of package objects */
> > +    /* Complete the initialization/resolution of new objects */
> >
> > -    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> > -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> > +    AcpiNsInitializeObjects ();
> >
> >     /* Parameter Data (optional) */
> >
> > @@ -620,10 +619,11 @@ AcpiExLoadOp (
> >         return_ACPI_STATUS (Status);
> >     }
> >
> > -    /* Complete the initialization/resolution of package objects */
> > +    /* Complete the initialization/resolution of new objects */
> >
> > -    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> > -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> > +    AcpiExExitInterpreter ();
> > +    AcpiNsInitializeObjects ();
> > +    AcpiExEnterInterpreter ();
> >
> >     /* Store the DdbHandle into the Target operand */
> >
> > diff --git a/source/components/tables/tbxfload.c b/source/components/tables/tbxfload.c
> > index 217d54bf0..1e17db6c8 100644
> > --- a/source/components/tables/tbxfload.c
> > +++ b/source/components/tables/tbxfload.c
> > @@ -479,6 +479,13 @@ AcpiLoadTable (
> >     ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
> >     Status = AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
> >         ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
> > +    if (ACPI_SUCCESS (Status))
> > +    {
> > +        /* Complete the initialization/resolution of new objects */
> > +
> > +        AcpiNsInitializeObjects ();
> > +    }
> > +
> >     return_ACPI_STATUS (Status);
> > }
>
> Ok, I see your are taking this up (I was a bit unsure after your previous
> post). Thanks,

The $subject patch has been queued for 5.3.  If I should drop it,
please let me know.

Thanks!
