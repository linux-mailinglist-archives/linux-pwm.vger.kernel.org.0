Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9259816A4A8
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgBXLOV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 06:14:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33511 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgBXLOV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 06:14:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so10446417wmc.0
        for <linux-pwm@vger.kernel.org>; Mon, 24 Feb 2020 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rEL57opEJN8/M1hHG6RBhacoGA9dbpZI+caSv19yBPg=;
        b=Y2SB6Ot1NpA4yEtYlNlGVS6WbbYy62GylUKjUPQ9jAQ5GDwkSw/7FzCVsSoKPfcCsg
         VgStUYDM9NJEfKHihK4r/mgnsJtAhKNvw8ImGDx1p+kW1l7PWONzHMwtcK0p04PnOI+k
         DYBtasmbocFV3+GWMMUwzLg5E39R6/neBgial1l2jN5cMSC6aUNPmaGb7ytsYwEMOenL
         sXCVQtR42MbPQgo811lhsruXf2x84ZVoVB4C20djzpEc1k9amNtHyLK60FArjQ0TjLcl
         egt2/DenXPKPfCl9gWypKExnmSXDTJ/bBABMEWP2jBIvWDY1IfnF/JOlFG5PMLg1wHG8
         ZWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rEL57opEJN8/M1hHG6RBhacoGA9dbpZI+caSv19yBPg=;
        b=DOpOEwCZgrfVKspdK1BwBhxdD0FABdmX+NYch1QqnHycOT4uRWclCQc9LppMZ18MGF
         YGK4ZKMkQ8dr/R8WLsUQWJHO89JUASHiq4uSnbgHhj4dPGX9Oucz22/kWEMeYaIm0Jqr
         lJpIzyBNoKbxQnvOCzuq76KBwzicsU45NSOqh22PUq57g+ubBEiMDHZ/SeuimiovBA5q
         rz1y4qZxp9mC6iG21xldD/DstxheSf7/xR72Ig9FRX5Kix+9qjZU/sCj/7v8hJPegUEs
         sAKjPTKmdA+ZUcQH/wDQhzlPjPgYcgIzCYYP9q/O0amrAx/q/U1kLzVVkRdYQlE3jn5k
         +z6A==
X-Gm-Message-State: APjAAAWgUJL3RXAxuBhyGM74p9y4a8GhJCdnvNByPqawpsh30ASBK2oG
        b3hXUk+Lx7mi98EIAKkEXkj9yQ==
X-Google-Smtp-Source: APXvYqyYDybLl6oJArR1E7Ob1XgcUlj3eWE/hkbMJ5C6QLsbf6VZzxRxzRyzLqwVHI9YWmytlHTlxw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr22455122wme.53.1582542858178;
        Mon, 24 Feb 2020 03:14:18 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id r5sm17483330wrt.43.2020.02.24.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 03:14:17 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:14:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200224111448.GS3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581895931-6056-3-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 16 Feb 2020, Jeff LaBundy wrote:

> This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
> IQS624 and IQS625 multi-function sensors.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v5:
>   - Merged iqs62x-core.c and iqs62x-tables.c into a single iqs62x.c
>   - Corrected spelling of "data sheet" to "datasheet"
>   - Added one line of whitespace in various places to improve readability
>   - Replaced iqs62x->map with iqs62x->regmap throughout
>   - Added the prox_settings member to the iqs62x_dev_desc struct and eliminated
>     the ternary operator in iqs62x_dev_init to determine SAR UI enable register
>     address
>   - Added a comment in iqs62x_dev_init to explain the background for the bounds
>     checking done on the IQS624/625 interval divider
>   - Added #defines for the delays used within iqs62x_dev_init
>   - Renamed iqs62x_fw_prs and iqs62x_fw_cb to iqs62x_firmware_parse and
>     iqs62x_firmware_load, respectively
>   - Updated the call to devm_mfd_add_devices to use PLATFORM_DEVID_NONE instead
>     of -1 and printed "sub-devices" instead of "devices" in the error message
>   - Dropped #defines for mfd_cell names in favor of the actual string names and
>     collapsed mfd_cells with no other members into one line
>   - Demoted iqs62x_devs to a static array as it is not used by any sub-devices
>   - Removed unnecessary { IQS620A_DEV, ... } enum and IQS62X_NUM_DEV #define
>   - Removed the soft reset and associated delay in iqs62x_probe to preserve any
>     PWM-related changes made by a bootloader
>   - Updated the comments in iqs62x_probe to highlight the significance of blank
>     calibration registers and why the outer loop may be exited early
>   - Made the first call to regmap_update_bits in iqs62x_suspend consistent with
>     other instances in the series that set a single bit by passing all ones for
>     the value instead of the mask
> 
> Changes in v4:
>   - None
> 
> Changes in v3:
>   - None
> 
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in start-up
>     delays and replaced ATI timeout routine with regmap_read_poll_timeout
>   - Added an error message to iqs62x_irq in case device status fails to be read
>   - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_probe
>     as the former was unused anywhere else
>   - Added comments throughout iqs62x_probe to clarify how devices are matched
>     based on the presence of calibration data
>   - Inverted the product and software number comparison logic in iqs62x_probe
>     to avoid an else...continue branch
>   - Changed iqs62x_probe from .probe callback to .probe_new callback, thereby
>     eliminating the otherwise unused iqs62x_id array
>   - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
>   - Eliminated tabbed alignment of regmap_config and i2c_driver struct members
>   - Added register definitions for register addresses used in iqs621_cal_regs,
>     iqs620at_cal_regs and iqs62x_devs arrays
>   - Removed of_compatible string from IQS622 mfd_cell struct as its proximity
>     (now ambient light) sensing functionality need not be represented using a
>     child node
>   - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_flags
>     and als_flags
>   - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP register
>     enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby re-
>     ducing IQS62X_EVENT_SIZE to 10) as they were unused
> 
>  drivers/mfd/Kconfig        |   13 +
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/iqs62x.c       | 1063 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/iqs62x.h |  139 ++++++
>  4 files changed, 1216 insertions(+)
>  create mode 100644 drivers/mfd/iqs62x.c
>  create mode 100644 include/linux/mfd/iqs62x.h

Well done Jeff.  Good job.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
