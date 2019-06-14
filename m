Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508EE45853
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2019 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFNJNF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jun 2019 05:13:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32773 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNJNE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jun 2019 05:13:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id p4so2016299oti.0;
        Fri, 14 Jun 2019 02:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQKOlho3IePwEIN90jAdwdDwovI9WsnmIGTODVgkjRA=;
        b=WBt42ZFsjkB1h+W59AEmW0p5Z4PbncLAzeV7iKPVlD7QvQ9y2IT96iXNMvAaPvBZ9T
         kRypHl/oFlCIe9FQwmX2HizCmXz1mn7xXMMBTgmWJwP5zhs0xdc5J8+A3J0zzmjITFgy
         YXwY53hLE3WZY2zcjfJt0pECB/c4SFYu4lkEHDr+ViYw0Z73lawdd1XkJDJIiojbhg19
         IM0VlvJkQuGKP73ImtI2UpZVMxw/VIYTU2yj90HdX2qnxEX+mMQLiVCpvdMGICkDUsSk
         5AVj2BjxWjA1TK6dpx6Ixr4qzMFPp+1k/nO5Rhd5Wmfqaxy6t2KeNpr3mJK1h9DlTgIy
         tE8w==
X-Gm-Message-State: APjAAAXF07kaErJ4haKJqz+S1idWeYEYZed0uniVnjQ9T0lCeNSeuNFW
        N4axdw0modMa5gQJ3NmPag31s54hLH+9NlVD9A0=
X-Google-Smtp-Source: APXvYqwmdZTMd2v6GPlEy1a/TL7qrJsrqpXKgBAz63iJnH2gtW407SGicB8TN5jAyyOvInGV4i/vIKKPF+eAlUMk8A4=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr2077918otp.189.1560503583969;
 Fri, 14 Jun 2019 02:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de> <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 11:12:53 +0200
Message-ID: <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table loads
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
>
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

This is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or if you want me to take this patch (without the other two in the
series), please let me know.

As for the other two patches, someone else needs to review them for
you as I'm not particularly familiar with the PWM subsystem.

> ---
>  drivers/acpi/acpi_configfs.c   |  6 +-----
>  drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index f92033661239..663f0d88f912 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>         if (!table->header)
>                 return -ENOMEM;
>
> -       ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> -       ret = acpi_tb_install_and_load_table(
> -                       ACPI_PTR_TO_PHYSADDR(table->header),
> -                       ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
> -                       &table->index);
> +       ret = acpi_load_table(table->header);
>         if (ret) {
>                 kfree(table->header);
>                 table->header = NULL;
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 4f30f06a6f78..ef8f8a9f3c9c 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>         status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>                                                 ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>                                                 FALSE, &table_index);
> +
> +       if (ACPI_SUCCESS(status)) {
> +               /* Complete the initialization/resolution of package objects */
> +
> +               status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
> +                                               ACPI_ROOT_OBJECT,
> +                                               ACPI_UINT32_MAX, 0,
> +                                               acpi_ns_init_one_package,
> +                                               NULL, NULL, NULL);
> +       }
> +
>         return_ACPI_STATUS(status);
>  }
>
> --
> 2.17.1
>
