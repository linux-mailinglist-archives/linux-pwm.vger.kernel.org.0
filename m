Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337AB20F63E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbgF3NwR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 09:52:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:9541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388508AbgF3Nv7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:59 -0400
IronPort-SDR: 3iB4B89a40QTCVcgP+jZdUcXtAehkAIECJlvdoEIzGDveSYilzpyDtZxc9kEAO1zaaYsQ3WGps
 ib+lfztyY3nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211297685"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="211297685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:51:58 -0700
IronPort-SDR: XKukowqspT+Ukx2NVyUVAxLdfpPpXh84dw+YvvRYLdUTHkl/s+XZZxhzq5+aVOtwdf862+OOl7
 PcfQIlh2qscg==
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="454614744"
Received: from rgrotewx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:51:53 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/15] acpi/pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the atomic PWM API
In-Reply-To: <20200620121758.14836-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200620121758.14836-1-hdegoede@redhat.com>
Date:   Tue, 30 Jun 2020 16:51:50 +0300
Message-ID: <874kqsmzk9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 20 Jun 2020, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is v3 of my patch series converting the i915 driver's code for
> controlling the panel's backlight with an external PWM controller to
> use the atomic PWM API. See below for the changelog.
>
> Initially the plan was for this series to consist of 2 parts:
> 1. convert the pwm-crc driver to support the atomic PWM API and
> 2. convert the i915 driver's PWM code to use the atomic PWM API.
>
> But during testing I've found a number of bugs in the pwm-lpss and I
> found that the acpi_lpss code needs some special handling because of
> some ugliness found in most Cherry Trail DSDTs.
>
> So now this series has grown somewhat large and consists of 4 parts:
>
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
>
> So we need to discuss how to merge this (once it passes review).
> Although the inter-dependencies are only runtime I still think we should
> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
> merging the i915 changes. Both to make sure that the intel-gfx CI system
> does not become unhappy and for bisecting reasons.
>
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn, so
> it likely is the easiest to just merge everything through dinq.
>
> Rafael and Thierry, can I get your Acked-by for directly merging this into
> dinq?
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

For the drm/i915 patches 12-15,

Acked-by: Jani Nikula <jani.nikula@intel.com>

I eyeballed through them, and didn't spot anything obviously wrong, but
at the same time didn't have the time to do an in-depth review. That
said, I do have a lot of trust in you testing this with all the above
devices. I think that's enough for merging.

As for that matter, I'm fine with merging this via whichever tree you
find best. Kind of stating the obvious, but please do ensure you have
the proper acks in place for this.


BR,
Jani.



>
> Changelog:
>
> Changes in v2:
> - Fix coverletter subject
> - Drop accidentally included debugging patch
> - "[PATCH v3 02/15] ACPI / LPSS: Save Cherry Trail PWM ctx registers only once (
>   - Move #define LPSS_SAVE_CTX_ONCE define to group it with LPSS_SAVE_CTX
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
> Regards,
>
> Hans
>

-- 
Jani Nikula, Intel Open Source Graphics Center
