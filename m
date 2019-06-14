Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA5845892
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2019 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfFNJ0W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jun 2019 05:26:22 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:50578 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFNJ0W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jun 2019 05:26:22 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id D56394CEDA; Fri, 14 Jun 2019 11:25:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id D098E4CDFA;
        Fri, 14 Jun 2019 11:25:58 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:25:58 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        linux-leds@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
In-Reply-To: <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de> <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de> <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rafael,

On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>>
>> If an ACPI SSDT overlay is loaded after built-in tables
>> have been loaded e.g. via configfs or efivar_ssdt_load()
>> it is necessary to rewalk the namespace to resolve
>> references. Without this, relative and absolute paths
>> like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
>> correctly.
>>
>> Make configfs load use the same method as efivar_ssdt_load().
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> This is fine by me, so
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Or if you want me to take this patch (without the other two in the
> series), please let me know.

thanks. I think it would be the best if you take up this patch as it is an 
independent topic. In retrospect it wasn't a good idea to put it into this 
series.

Kind regards,
Niko

[...]
