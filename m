Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98395231CFD
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2Kyl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 06:54:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:14857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG2Kyk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 06:54:40 -0400
IronPort-SDR: mqvo9oRK/BxpGjOdJthbcoEMiFW+CyUeAGY44iXofi28K5s/4kxWjRCHgiqCuiDGWATIDf0RkZ
 6EhpE8+e/HxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="152628857"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="152628857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:54:39 -0700
IronPort-SDR: e+5s9P2TRXoi+l+qwUMRp8L5qglmtwzrocxuYCYRWvPfg6jRnjspIUD9UKoalv8PWpTVvFTJyd
 PmBu8DE07N8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="464819957"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 29 Jul 2020 03:54:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jjI-004fvg-45; Wed, 29 Jul 2020 13:54:36 +0300
Date:   Wed, 29 Jul 2020 13:54:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915
 driver's PWM code to use the atomic PWM API
Message-ID: <20200729105436.GT3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v5 of my patch series converting the i915 driver's code for
> controlling the panel's backlight with an external PWM controller to
> use the atomic PWM API. See below for the changelog.
> 
> This series consists of 4 parts:
> 
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
> 
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
> so the plan is to merge this all through drm-intel-next-queued (dinq)
> once all the patches are reviewed / have acks.
> 
> Specifically patches 5-9, 11 still need an Acked- / Reviewed-by
> 
> Andy, can you please take a look at the unreviewed patches? Specifically
> patches 5-6 should address your review remarks from v4 of this set
> and I've addressed your review remarks on patches 7-9 in v3 already.
> A review of patch 11 would also be welcome

Done. Sorry for a delay.

One comment to consider, though. There are three channels in that PWM AFAIU.
One of them is backlight control, another one can be attached to haptics. The
concern is how this series may (or may not?) affect haptics behaviour.

> Uwe, can you please take a look at the unreviewed patches?
> 
> Uwe, may I have your Acked-by for merging this series through the
> drm-intel-next-queued branch once all PWM patches have an Acked- or
> Reviewed-by ?
> 
> This series has been tested (and re-tested after adding various bug-fixes)
> extensively. It has been tested on the following devices:
> 
> -Asus T100TA  BYT + CRC-PMIC PWM
> -Toshiba WT8-A  BYT + CRC-PMIC PWM
> -Thundersoft TS178 BYT + CRC-PMIC PWM, inverse PWM
> -Asus T100HA  CHT + CRC-PMIC PWM
> -Terra Pad 1061  BYT + LPSS PWM
> -Trekstor Twin 10.1 BYT + LPSS PWM
> -Asus T101HA  CHT + CRC-PMIC PWM
> -GPD Pocket  CHT + CRC-PMIC PWM
> 
> Changelog:
> Changes in v5:
> - Dropped the "pwm: lpss: Correct get_state result for base_unit == 0"
>   patch. The base_unit == 0 condition should never happen and sofar it is
>   unclear what the proper behavior / correct values to store in the
>   pwm_state should be when this does happen.  Since this patch was added as
>   an extra pwm-lpss fix in v4 of this patch-set and otherwise is orthogonal
>   to the of this patch-set just drop it (again).
> - "[PATCH 04/16] pwm: lpss: Add range limit check for the base_unit register value"
>   - Use clamp_val(... instead of clam_t(unsigned long long, ...
> - "[PATCH 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper"
>   - This is a new patch in v5 of this patchset
> - [PATCH 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring state on resume
>   - Use the new pwm_lpss_prepare_enable() helper
> 
> Changes in v4:
> - "[PATCH v4 06/16] pwm: lpss: Correct get_state result for base_unit == 0"
>   - This is a new patch in v4 of this patchset
> - "[PATCH v4 12/16] pwm: crc: Implement get_state() method"
>   - Use DIV_ROUND_UP when calculating the period and duty_cycle values
> - "[PATCH v4 16/16] drm/i915: panel: Use atomic PWM API for devs with an external PWM controller"
>   - Add a note to the commit message about the changes in pwm_disable_backlight()
>   - Use the pwm_set/get_relative_duty_cycle() helpers
> 
> Changes in v3:
> - "[PATCH v3 04/15] pwm: lpss: Add range limit check for the base_unit register value"
>   - Use base_unit_range - 1 as maximum value for the clamp()
> - "[PATCH v3 05/15] pwm: lpss: Use pwm_lpss_apply() when restoring state on resume"
>   - This replaces the "pwm: lpss: Set SW_UPDATE bit when enabling the PWM"
>     patch from previous versions of this patch-set, which really was a hack
>     working around the resume issue which this patch fixes properly.
> - PATCH v3 6 - 11 pwm-crc changes:
>   - Various small changes resulting from the reviews by Andy and Uwe,
>     including some refactoring of the patches to reduce the amount of churn
>     in the patch-set
> 
> Changes in v2:
> - Fix coverletter subject
> - Drop accidentally included debugging patch
> - "[PATCH v3 02/15] ACPI / LPSS: Save Cherry Trail PWM ctx registers only once (
>   - Move #define LPSS_SAVE_CTX_ONCE define to group it with LPSS_SAVE_CTX
> 
> Regards,
> 
> Hans
> 

-- 
With Best Regards,
Andy Shevchenko


