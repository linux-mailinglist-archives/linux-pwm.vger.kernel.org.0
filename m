Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE437A7CA7
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2019 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfIDHUM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Sep 2019 03:20:12 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:37734 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDHUH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Sep 2019 03:20:07 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id E39DE4BAE9; Wed,  4 Sep 2019 09:20:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id E002A48322;
        Wed,  4 Sep 2019 09:20:03 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:20:03 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
In-Reply-To: <20190830145348.GM2680@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.20.1909040913230.15999@fox.voss.local>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de> <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de> <20190814185055.GZ30120@smile.fi.intel.com> <CF6A88132359CE47947DB4C6E1709ED53C61A211@ORSMSX122.amr.corp.intel.com>
 <alpine.DEB.2.20.1908161345590.41303@fox.voss.local> <20190830145348.GM2680@smile.fi.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Andy,

On Fri, 30 Aug 2019, Shevchenko, Andriy wrote:
> On Fri, Aug 16, 2019 at 01:57:26PM +0200, Nikolaus Voss wrote:
>> On Wed, 14 Aug 2019, Schmauss, Erik wrote:
>>>> -----Original Message-----
>>>> From: Shevchenko, Andriy
>>>> Sent: Wednesday, August 14, 2019 11:51 AM
>>>> To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
>>>> Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
>>>> <erik.schmauss@intel.com>; Jacek Anaszewski <jacek.anaszewski@gmail.com>;
>>>> Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; Thierry
>>>> Reding <thierry.reding@gmail.com>; linux-acpi@vger.kernel.org;
>>>> devel@acpica.org; linux-leds@vger.kernel.org; linux-pwm@vger.kernel.org
>>>> Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
>>>>
>>>> On Wed, May 29, 2019 at 02:18:20PM +0200, Nikolaus Voss wrote:
>>>>> If an ACPI SSDT overlay is loaded after built-in tables have been
>>>>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
>>>>> rewalk the namespace to resolve references. Without this, relative and
>>>>> absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
>>>>> correctly.
>>>>>
>>>>> Make configfs load use the same method as efivar_ssdt_load().
>>>>
>>>> This patch brought a regression (bisect log below).
>>>> Now I'm unable to unload the table which was working before.
>>>>
>>>> Reverting (manual, due to ACPICA changes) helps.
>>>>
>>>> Please, consider to revert for this cycle, or fix. I will be glad to test any
>>>> proposed fix.
>>>
>>> We submitted a patch (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
>>> in response to this suggestion and I was not aware that this had been applied.
>>>
>>> Rafael, please revert at least the ACPICA portion of this patch.
>>
>> As I see it, my ACPICA change is not part of 5.3-rc1 any more. Reverting my
>> fix is part of the patch above (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
>> which is already applied.
>>
>> Nevertheless, what is new, is that acpi_ns_initialize_objects() is called in
>> acpi_load_table(). This is necessary to resolve the references in the newly
>> loaded table. Maybe this prevents the table from being unloaded?
>
> So, can we do something about it? It's a regression.
>
> Rafael, Nikolaus?

can you describe how you unload the table (from userspace?). I cannot 
reproduce this regression. I was not aware of any working interface for 
unloading ACPI tables, I ended up in kexec'ing the kernel for my tests 
each time I had to unload a table.

Niko
