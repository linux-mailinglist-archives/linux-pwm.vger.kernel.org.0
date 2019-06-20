Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B84C7A9
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2019 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFTGtb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jun 2019 02:49:31 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:60686 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfFTGtb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jun 2019 02:49:31 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 2BDDB4D00C; Thu, 20 Jun 2019 08:49:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 295AA4D000;
        Thu, 20 Jun 2019 08:49:28 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:49:28 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Moore, Robert" <robert.moore@intel.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FC28D@ORSMSX110.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1906200843320.9673@fox.voss.local>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de> <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de> <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com> <alpine.DEB.2.20.1906170746150.12344@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local>    <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com> <alpine.DEB.2.20.1906191123400.34742@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FC28D@ORSMSX110.amr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 19 Jun 2019, Moore, Robert wrote:
>
>
>> -----Original Message-----
>> From: Nikolaus Voss [mailto:nv@vosn.de]
>> Sent: Wednesday, June 19, 2019 2:31 AM
>> To: Moore, Robert <robert.moore@intel.com>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J. Wysocki
>> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Schmauss, Erik
>> <erik.schmauss@intel.com>; Jacek Anaszewski
>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
>> <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI Devel
>> Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT
>> ARCHITECTURE (ACPICA) <devel@acpica.org>; linux-leds@vger.kernel.org;
>> Linux PWM List <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>; nikolaus.voss@loewensteinmedical.de
>> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
>> loads
>>
>> Hi Bob,
>>
>> On Tue, 18 Jun 2019, Moore, Robert wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Moore, Robert
>>>> Sent: Tuesday, June 18, 2019 1:25 PM
>>>> To: 'Nikolaus Voss' <nv@vosn.de>
>>>> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
>>>> <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
>>>> <erik.schmauss@intel.com>; 'Jacek Anaszewski'
>>>> <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
>>>> Murphy' <dmurphy@ti.com>; 'Thierry Reding'
>>>> <thierry.reding@gmail.com>; 'ACPI Devel Maling List'
>>>> <linux-acpi@vger.kernel.org>; 'open list:ACPI COMPONENT ARCHITECTURE
>>>> (ACPICA)' <devel@acpica.org>; 'linux- leds@vger.kernel.org' <linux-
>> leds@vger.kernel.org>; 'Linux PWM List'
>>>> <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
>>>> kernel@vger.kernel.org>
>>>> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
>>>> table loads
>>>>
>>>> If it is in fact the AcpiLoadTable interface that is incorrect, that
>>>> of course is different. I'll check that out next.
>>>>
>>> [Moore, Robert]
>>>
>>> Yes, this is the issue, not specifically the Load() operator, but the
>>> AcpiLoadTable interface only.
>>
>> thanks for checking this out. So what is the conclusion? Is my fix of
>> AcpiLoadTable() sufficient or do we need a different solution?
>>
>> Niko
>>
>
>
> Your change is in the correct area. We want to do something like this, however:
>
> diff --git a/source/components/executer/exconfig.c b/source/components/executer/exconfig.c
> index 84a058ada..eba1a6d28 100644
> --- a/source/components/executer/exconfig.c
> +++ b/source/components/executer/exconfig.c
> @@ -342,10 +342,9 @@ AcpiExLoadTableOp (
>         return_ACPI_STATUS (Status);
>     }
>
> -    /* Complete the initialization/resolution of package objects */
> +    /* Complete the initialization/resolution of new objects */
>
> -    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> +    AcpiNsInitializeObjects ();
>
>     /* Parameter Data (optional) */
>
> @@ -620,10 +619,11 @@ AcpiExLoadOp (
>         return_ACPI_STATUS (Status);
>     }
>
> -    /* Complete the initialization/resolution of package objects */
> +    /* Complete the initialization/resolution of new objects */
>
> -    Status = AcpiNsWalkNamespace (ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> -        ACPI_UINT32_MAX, 0, AcpiNsInitOnePackage, NULL, NULL, NULL);
> +    AcpiExExitInterpreter ();
> +    AcpiNsInitializeObjects ();
> +    AcpiExEnterInterpreter ();
>
>     /* Store the DdbHandle into the Target operand */
>
> diff --git a/source/components/tables/tbxfload.c b/source/components/tables/tbxfload.c
> index 217d54bf0..1e17db6c8 100644
> --- a/source/components/tables/tbxfload.c
> +++ b/source/components/tables/tbxfload.c
> @@ -479,6 +479,13 @@ AcpiLoadTable (
>     ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
>     Status = AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
>         ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
> +    if (ACPI_SUCCESS (Status))
> +    {
> +        /* Complete the initialization/resolution of new objects */
> +
> +        AcpiNsInitializeObjects ();
> +    }
> +
>     return_ACPI_STATUS (Status);
> }

Ok, I see your are taking this up (I was a bit unsure after your previous 
post). Thanks,
Niko
