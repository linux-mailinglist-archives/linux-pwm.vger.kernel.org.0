Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71B12DCA4
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfE2MZf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 08:25:35 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:53054 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfE2MZf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 08:25:35 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 23E174BB0E;
        Wed, 29 May 2019 14:18:39 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] PWM framework: add support referencing PWMs from ACPI 
Date:   Wed, 29 May 2019 14:18:19 +0200
Message-Id: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As described in Documentation/firmware-guide/acpi/gpio-properties.rst a
GPIO can be referenced from ACPI ASL _DSD with the "gpios"-property of the
form:

  Package () { "gpios", Package () { ref, index, pin, active_low }}

The second patch of this series adds support for specifing a PWM
reference in ASL of the form

  Package () { "pwms", Package () { ref, index, pwm-period [, pwm flags]}}

The first patch of this series is necessary to resolve the "ref" in ASL
if the table has been loaded by efivar_ssdt_load() or configfs.

The third patch of this series makes leds-pwm use the ACPI-enabled
PWM framework.

Nikolaus Voss (3):
  ACPI: Resolve objects on host-directed table loads
  PWM framework: add support referencing PWMs from ACPI
  leds-pwm.c: support ACPI via firmware-node framework

 drivers/acpi/acpi_configfs.c   |   6 +-
 drivers/acpi/acpica/tbxfload.c |  11 ++++
 drivers/leds/leds-pwm.c        |  44 +++++++------
 drivers/pwm/core.c             | 112 +++++++++++++++++++++++++++++++++
 include/linux/pwm.h            |   9 +++
 5 files changed, 159 insertions(+), 23 deletions(-)

-- 
2.17.1

