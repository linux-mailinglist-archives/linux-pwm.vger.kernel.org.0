Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63E30E4A
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaMpt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 08:45:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaMpt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 08:45:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4VCjZ4f127851;
        Fri, 31 May 2019 07:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559306735;
        bh=Uht3l3wpjzLKieiT9/6U03Qo1W+gTOwjMjGwNeyfRlQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gEIe8QIy5LdRlG6iaKPzTLaBcdDtQEq0YnsrVbISG3QgdO+TYmf647GoDg4rHF8WJ
         jr7O7RJPyJvUzVns3b1tnxKR7hrp2aIypzcoBl7MoNsy1Z4+o9U/JOyNb81veWlivu
         Ic/GMLljsIYXfn3PIzRGM9BRwkwOZiYC4oZR3kII=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4VCjZLh060978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 May 2019 07:45:35 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 31
 May 2019 07:45:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 31 May 2019 07:45:35 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4VCjYDQ064106;
        Fri, 31 May 2019 07:45:34 -0500
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
To:     Pavel Machek <pavel@ucw.cz>
CC:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-leds@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <2944848d-d004-6750-b95d-825b1758ff22@ti.com> <20190531122320.GB3722@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <422b875b-c450-1aab-f190-ab8388df1dda@ti.com>
Date:   Fri, 31 May 2019 07:45:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531122320.GB3722@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Pavel

On 5/31/19 7:23 AM, Pavel Machek wrote:
> Hi!
>
>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
>>> index 4f30f06a6f78..61f2d46e52ba 100644
>>> --- a/drivers/acpi/acpica/tbxfload.c
>>> +++ b/drivers/acpi/acpica/tbxfload.c
>>> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>>>   	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>>>   						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>>>   						FALSE, &table_index);
>>> +
>>> +	if (!ACPI_FAILURE(status)) {
>> Checkpatch should complain about putting brackets around single statement
>> if's.
> With multiline statement like that and including comment -- I'd say
> keep {'s. It is cleaner this way.

Maintainers preference.  I won't nack the patch for it.

Not sure their preference as I don't usually submit to acpi.

Dan


> 									Pavel
>
>
