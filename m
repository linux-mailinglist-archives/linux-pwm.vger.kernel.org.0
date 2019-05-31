Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712B630E50
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaMqc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 08:46:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfEaMqc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 08:46:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4VCkLmF120243;
        Fri, 31 May 2019 07:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559306781;
        bh=3mnPV3T2GcEEK7hfjJaRX34/fY3geOiCoV4TEkYlC9c=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ZfURkIDkrQCU3I5j3XfaaRDiSTvmVEzeKoUJANiT8G/i5jc4PbY9iJXSuYggEdX46
         ZH+Oe8HSW22Ikb67H+ypLaAiFgoI5/1viqkQpUrv/tOePRLL86xVhZRmCSPIYUfAQ7
         1HmGhTzN0rePKu7Nj+kO6EsjqA4nLx12nR1HAk80=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4VCkLfx063198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 May 2019 07:46:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 31
 May 2019 07:46:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 31 May 2019 07:46:19 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4VCkJA1063192;
        Fri, 31 May 2019 07:46:19 -0500
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
From:   Dan Murphy <dmurphy@ti.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-leds@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
Message-ID: <e5ed5715-2fc0-be77-0cb2-2cae57de4b98@ti.com>
Date:   Fri, 31 May 2019 07:46:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Nikolaus

On 5/30/19 9:42 AM, Dan Murphy wrote:
> Nikolaus
>
> On 5/29/19 7:18 AM, Nikolaus Voss wrote:
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
>> ---
>>   drivers/acpi/acpi_configfs.c   |  6 +-----
>>   drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>>   2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
>> index f92033661239..663f0d88f912 100644
>> --- a/drivers/acpi/acpi_configfs.c
>> +++ b/drivers/acpi/acpi_configfs.c
>> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct 
>> config_item *cfg,
>>       if (!table->header)
>>           return -ENOMEM;
>>   -    ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
>> -    ret = acpi_tb_install_and_load_table(
>> -            ACPI_PTR_TO_PHYSADDR(table->header),
>> -            ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
>> -            &table->index);
>> +    ret = acpi_load_table(table->header);
>>       if (ret) {
>>           kfree(table->header);
>>           table->header = NULL;
>> diff --git a/drivers/acpi/acpica/tbxfload.c 
>> b/drivers/acpi/acpica/tbxfload.c
>> index 4f30f06a6f78..61f2d46e52ba 100644
>> --- a/drivers/acpi/acpica/tbxfload.c
>> +++ b/drivers/acpi/acpica/tbxfload.c
>> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct 
>> acpi_table_header *table)
>>       status = 
>> acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>>                           ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>>                           FALSE, &table_index);
>> +
>> +    if (!ACPI_FAILURE(status)) {
> Checkpatch should complain about putting brackets around single 
> statement if's.

Would ACPI_SUCCESS make more sense here?

Dan

<snip>
