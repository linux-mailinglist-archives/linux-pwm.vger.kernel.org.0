Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9912FE23
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE3Omw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 10:42:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfE3Omv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 10:42:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4UEgXYZ008364;
        Thu, 30 May 2019 09:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559227353;
        bh=vdsGY18VVY30lY50Nd0I6augLPBryxvzdQFjzsDof+w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cqnO1fDKE6x3guaATLqTvQRjm7NrcumHTQPKk8IspUpu5nvAWLyIBWNiI3YJF/Peo
         ZSFi1l7zBzFqpZqM9sV9I1FOtxT8UhNHZNsOx8f4Ilx9awOJe+L4MTUOK3h7mVBZxx
         0cOt86Nw8CRlNP5ZgNR2ASeyqSIh0XjmrI7Xd67Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4UEgXpB110052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 May 2019 09:42:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 30
 May 2019 09:42:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 30 May 2019 09:42:32 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4UEgWp3000708;
        Thu, 30 May 2019 09:42:32 -0500
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
Date:   Thu, 30 May 2019 09:42:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Nikolaus

On 5/29/19 7:18 AM, Nikolaus Voss wrote:
> If an ACPI SSDT overlay is loaded after built-in tables
> have been loaded e.g. via configfs or efivar_ssdt_load()
> it is necessary to rewalk the namespace to resolve
> references. Without this, relative and absolute paths
> like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
> correctly.
>
> Make configfs load use the same method as efivar_ssdt_load().
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>   drivers/acpi/acpi_configfs.c   |  6 +-----
>   drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index f92033661239..663f0d88f912 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>   	if (!table->header)
>   		return -ENOMEM;
>   
> -	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> -	ret = acpi_tb_install_and_load_table(
> -			ACPI_PTR_TO_PHYSADDR(table->header),
> -			ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
> -			&table->index);
> +	ret = acpi_load_table(table->header);
>   	if (ret) {
>   		kfree(table->header);
>   		table->header = NULL;
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 4f30f06a6f78..61f2d46e52ba 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>   	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>   						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>   						FALSE, &table_index);
> +
> +	if (!ACPI_FAILURE(status)) {
Checkpatch should complain about putting brackets around single 
statement if's.
> +		/* Complete the initialization/resolution of package objects */
> +

Extra new lines


Dan

> +		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
> +						ACPI_ROOT_OBJECT,
> +						ACPI_UINT32_MAX, 0,
> +						acpi_ns_init_one_package,
> +						NULL, NULL, NULL);
> +	}
> +
>   	return_ACPI_STATUS(status);
>   }
>   
