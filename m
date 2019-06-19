Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320994B4F2
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfFSJbH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:31:07 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:44812 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSJbH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:31:07 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 03C774D232; Wed, 19 Jun 2019 11:31:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 013374D22D;
        Wed, 19 Jun 2019 11:31:02 +0200 (CEST)
Date:   Wed, 19 Jun 2019 11:31:01 +0200 (CEST)
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nikolaus.voss@loewensteinmedical.de
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1906191123400.34742@fox.voss.local>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de> <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de> <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com> <alpine.DEB.2.20.1906170746150.12344@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local>    <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bob,

On Tue, 18 Jun 2019, Moore, Robert wrote:
>
>
>> -----Original Message-----
>> From: Moore, Robert
>> Sent: Tuesday, June 18, 2019 1:25 PM
>> To: 'Nikolaus Voss' <nv@vosn.de>
>> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
>> <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
>> <erik.schmauss@intel.com>; 'Jacek Anaszewski'
>> <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
>> Murphy' <dmurphy@ti.com>; 'Thierry Reding' <thierry.reding@gmail.com>;
>> 'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>; 'open list:ACPI
>> COMPONENT ARCHITECTURE (ACPICA)' <devel@acpica.org>; 'linux-
>> leds@vger.kernel.org' <linux-leds@vger.kernel.org>; 'Linux PWM List'
>> <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
>> kernel@vger.kernel.org>
>> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
>> loads
>>
>> If it is in fact the AcpiLoadTable interface that is incorrect, that of
>> course is different. I'll check that out next.
>>
> [Moore, Robert]
>
> Yes, this is the issue, not specifically the Load() operator, but the 
> AcpiLoadTable interface only.

thanks for checking this out. So what is the conclusion? Is my fix 
of AcpiLoadTable() sufficient or do we need a different solution?

Niko

[...]
