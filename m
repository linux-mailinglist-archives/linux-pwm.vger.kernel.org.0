Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E879832C53
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfFCJNE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 05:13:04 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:35866 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfFCJND (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Jun 2019 05:13:03 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 0393B472C1; Mon,  3 Jun 2019 11:13:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 01EA74544D;
        Mon,  3 Jun 2019 11:12:59 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:12:59 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Dan Murphy <dmurphy@ti.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
In-Reply-To: <e5ed5715-2fc0-be77-0cb2-2cae57de4b98@ti.com>
Message-ID: <alpine.DEB.2.20.1906031111420.62985@fox.voss.local>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de> <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de> <2944848d-d004-6750-b95d-825b1758ff22@ti.com> <e5ed5715-2fc0-be77-0cb2-2cae57de4b98@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-975137946-1559553180=:62985"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-975137946-1559553180=:62985
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Dan,

On Fri, 31 May 2019, Dan Murphy wrote:
> Nikolaus
>
> On 5/30/19 9:42 AM, Dan Murphy wrote:
>> Nikolaus
>>
>> On 5/29/19 7:18 AM, Nikolaus Voss wrote:
>>> If an ACPI SSDT overlay is loaded after built-in tables
>>> have been loaded e.g. via configfs or efivar_ssdt_load()
>>> it is necessary to rewalk the namespace to resolve
>>> references. Without this, relative and absolute paths
>>> like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
>>> correctly.
>>>
>>> Make configfs load use the same method as efivar_ssdt_load().
>>>
>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>> ---
>>>   drivers/acpi/acpi_configfs.c   |  6 +-----
>>>   drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>>>   2 files changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
>>> index f92033661239..663f0d88f912 100644
>>> --- a/drivers/acpi/acpi_configfs.c
>>> +++ b/drivers/acpi/acpi_configfs.c
>>> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct
>>> config_item *cfg,
>>>       if (!table->header)
>>>           return -ENOMEM;
>>>   -    ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
>>> -    ret = acpi_tb_install_and_load_table(
>>> -            ACPI_PTR_TO_PHYSADDR(table->header),
>>> -            ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
>>> -            &table->index);
>>> +    ret = acpi_load_table(table->header);
>>>       if (ret) {
>>>           kfree(table->header);
>>>           table->header = NULL;
>>> diff --git a/drivers/acpi/acpica/tbxfload.c
>>> b/drivers/acpi/acpica/tbxfload.c
>>> index 4f30f06a6f78..61f2d46e52ba 100644
>>> --- a/drivers/acpi/acpica/tbxfload.c
>>> +++ b/drivers/acpi/acpica/tbxfload.c
>>> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct
>>> acpi_table_header *table)
>>>       status =
>>> acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>>>                           ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>>>                           FALSE, &table_index);
>>> +
>>> +    if (!ACPI_FAILURE(status)) {
>> Checkpatch should complain about putting brackets around single
>> statement if's.
>
> Would ACPI_SUCCESS make more sense here?

yes, changed.
--8323329-975137946-1559553180=:62985--
