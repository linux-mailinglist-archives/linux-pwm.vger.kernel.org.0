Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0294425BF67
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgICKv0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 06:51:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgICKvZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 06:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599130284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2jfkitntswutOLQ1DY1OiWZZ+qzs7EZXcRyjoLVfEWI=;
        b=DdmqP1jzF8gNfKRXqupdTQt0B0B1lCMKClfoqUH+/2ZlKXstDW9o1L+X+vmDbdGqpeFJ0j
        DxWeelSPE5oPiRAKLVuba4xMJi80V+RwvTqXKoZ4yvAjwD/HWgoU3luTLxWeFPK1nE4RTw
        FB9c74JRCEvQxkt8CiprsmokrUPVoqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-EEOplwD-PNqAcZIQbpPObA-1; Thu, 03 Sep 2020 06:51:22 -0400
X-MC-Unique: EEOplwD-PNqAcZIQbpPObA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F051091062;
        Thu,  3 Sep 2020 10:51:19 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-4.ams2.redhat.com [10.36.115.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8A2D7EEAE;
        Thu,  3 Sep 2020 10:51:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v9 00/17] acpi/pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the atomic PWM API
Date:   Thu,  3 Sep 2020 12:50:57 +0200
Message-Id: <20200903105114.9969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

So the bug-fix which prompted v8, lead to some discussion about the pwm-lpss
suspend/resume code. So as discussed this version drops the following 2
patches:

[PATCH v8 06/17] pwm: lpss: Use pwm_lpss_restore() when restoring state on resume
[PATCH v8 07/17] pwm: lpss: Always update state and set update bit

Replacing them with:

[PATCH v9 06/17] pwm: lpss: Make pwm_lpss_apply() not rely on hardware state
[PATCH v9 07/17] pwm: lpss: Remove suspend/resume handlers

Andy, Thierry, can you review these 2 new patches please?

The plan still is to push the entire series to drm-intel-next-queued
(because of interdependencies) once the 2 new patches are reviewed and
the series has passed CI.

This series has been tested (and re-tested after adding various bug-fixes)
extensively. It has been tested on the following devices:

-Asus T100TA  BYT + CRC-PMIC PWM
-Toshiba WT8-A  BYT + CRC-PMIC PWM
-Thundersoft TS178  BYT + CRC-PMIC PWM, inverse PWM
-Asus T100HA  CHT + CRC-PMIC PWM
-Terra Pad 1061  BYT + LPSS PWM
-Trekstor Twin 10.1  BYT + LPSS PWM
-Asus T101HA  CHT + LPSS PWM
-GPD Pocket  CHT + LPSS PWM
-Acer One S1003  CHT + LPSS PWM

Regards,

Hans


Changelog:

Changes in v9:
- Replace:
  [PATCH v8 06/17] pwm: lpss: Use pwm_lpss_restore() when restoring state on resume
  [PATCH v8 07/17] pwm: lpss: Always update state and set update bit
  with:
  [PATCH v9 06/17] pwm: lpss: Make pwm_lpss_apply() not rely on hardware state
  [PATCH v9 07/17] pwm: lpss: Remove suspend/resume handlers

Changes in v8:
- Add a new patch dealing with the ACPI/DSDT GFX0._PS3 code poking the PWM controller
  in unexpected ways on some Cherry Trail devices

Changes in v7:
- Fix a u64 divide leading to undefined reference to `__udivdi3' errors on 32 bit
  platforms by casting the divisor to an unsigned long

Changes in v6:
- Rebase on v5.9-rc1
- Adjust pwm-crc patches for pwm_state.period and .duty_cycle now being u64

Changes in v5:
- Dropped the "pwm: lpss: Correct get_state result for base_unit == 0"
  patch. The base_unit == 0 condition should never happen and sofar it is
  unclear what the proper behavior / correct values to store in the
  pwm_state should be when this does happen.  Since this patch was added as
  an extra pwm-lpss fix in v4 of this patch-set and otherwise is orthogonal
  to the of this patch-set just drop it (again).
- "[PATCH 04/16] pwm: lpss: Add range limit check for the base_unit register value"
  - Use clamp_val(... instead of clam_t(unsigned long long, ...
- "[PATCH 05/16] pwm: lpss: Add pwm_lpss_prepare_enable() helper"
  - This is a new patch in v5 of this patchset
- [PATCH 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring state on resume
  - Use the new pwm_lpss_prepare_enable() helper

Changes in v4:
- "[PATCH v4 06/16] pwm: lpss: Correct get_state result for base_unit == 0"
  - This is a new patch in v4 of this patchset
- "[PATCH v4 12/16] pwm: crc: Implement get_state() method"
  - Use DIV_ROUND_UP when calculating the period and duty_cycle values
- "[PATCH v4 16/16] drm/i915: panel: Use atomic PWM API for devs with an external PWM controller"
  - Add a note to the commit message about the changes in pwm_disable_backlight()
  - Use the pwm_set/get_relative_duty_cycle() helpers

Changes in v3:
- "[PATCH v3 04/15] pwm: lpss: Add range limit check for the base_unit register value"
  - Use base_unit_range - 1 as maximum value for the clamp()
- "[PATCH v3 05/15] pwm: lpss: Use pwm_lpss_apply() when restoring state on resume"
  - This replaces the "pwm: lpss: Set SW_UPDATE bit when enabling the PWM"
    patch from previous versions of this patch-set, which really was a hack
    working around the resume issue which this patch fixes properly.
- PATCH v3 6 - 11 pwm-crc changes:
  - Various small changes resulting from the reviews by Andy and Uwe,
    including some refactoring of the patches to reduce the amount of churn
    in the patch-set

Changes in v2:
- Fix coverletter subject
- Drop accidentally included debugging patch
- "[PATCH v3 02/15] ACPI / LPSS: Save Cherry Trail PWM ctx registers only once (
  - Move #define LPSS_SAVE_CTX_ONCE define to group it with LPSS_SAVE_CTX

