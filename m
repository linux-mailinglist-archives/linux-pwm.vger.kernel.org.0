Return-Path: <linux-pwm+bounces-4710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C0A1A196
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFE63A60A1
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8620D4FE;
	Thu, 23 Jan 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="231ehXwD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732720CCCC
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627092; cv=none; b=b6E1j5DxyINIA1fTzYSSOSOgnZ4smnzhe8sMS8Fh/wO1tVAKeSnzFQwZ8/5zAYy3HskvJJAMDeFc9+afhawyJzlbl7U4i+xl6Q6YexO7ZtJObGpKCamfwpdhTw4U1EvwnsPTzeHjhmKt2tLZU0EgaIMwWmTxLCUntckHD6FZFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627092; c=relaxed/simple;
	bh=0t2qfd3GnssXmR2y8LW0cKG7GonvDxo8t2BPTONaO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOzP73NZdzbOZx5b0Gm6GfODetwMOKEPl+FLSIn1UkJTlZcm1JGplDl8mzg889ECA0k7zeyF64Ht6i8NSMFS0uVC0LfC83zHwXK6C4mlxxQWTLp2ulS+RgD//j7/RBQOQKVN9XZtEDsti/yOwzamcckU1kKjxKs/rX1vpKyW4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=231ehXwD; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aaec111762bso162666266b.2
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737627087; x=1738231887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AkogUzy8jf2hIq992KtJA1R6WCK3IssbvI/CIUiwCk=;
        b=231ehXwD1nrTI16Hm7tBz6dt9ycpB94VjCBTV/9Nb/sEHsdW2k2OtXJfDEjKjdClTQ
         xHWIjkVPo0uZEI/mdEyKtghx+Ce5A7Q9VrQt5+kYLEsnQon7yOOXmOghLDHtrOmgx84+
         LLO/0nwCKj/gYW1F9I2M48NG0jIZzz+P8izK1eNnuGzPZPXVHpgrgWmRHmZTQhzWqIoB
         Xk0MkZTDcJaJfi2TBNFuCmBQ9wndMNABKPWv530P3HfaygczX9L/pkJi1RPfn/3dIA3I
         CGvvYG6eeVAmZkitmGz2lZ4SPTmKsElxWQQClzcrkVPPe6Zc+/v+Mo26S9C4e1wgEE0V
         Ojtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627087; x=1738231887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AkogUzy8jf2hIq992KtJA1R6WCK3IssbvI/CIUiwCk=;
        b=JfceUVNA0YC/B2ZFkC47Hsrb9EMiTDijDeQFvoBAIoHckKcESwxMNL2m0+aTEDa052
         AOQ5l9DuAQkZ5yWtvZQjSlyAqsHAvtirvkbYLkYVsZNp8NXnx+WFMo0pj+kJqxcDCn09
         6DQq6pTwPtxx61igCFtdhlrcBQG/IfSOtPWDmXjhHMhUetRdzI7aYRXRJdpsESzildl5
         Ssp4RbCSiOgCiSeyS9x7NRfcFnt2Vd3Ss/G8h/JRD8DJp+CPpKs2ULS+kf2VnZFfERKx
         C1KV6LJXG8HIiNhjKOB7S9WQlFDlvyMsPPdvaTj5zer7nMb5tuZH3T8qUTf5bJ/OkyDX
         Uurg==
X-Gm-Message-State: AOJu0Yx/TVWcJKfosoOPjMXLI53k+V1nVMUayTWNEABBdYPKtmEf/gXO
	4uwbmGwcSTHT4177UCOqMoF3dLsiPe5TfUJ94IbDI46Qsn/tOe2vYh5P3HzMQ+0=
X-Gm-Gg: ASbGnctBhaTYi+w0G8BdLf/tknQlk8QJ4kUS2ho78pA8KP+vw4DFKLU+5mZsPTqmqWV
	z/iVuYQ6I3Z7w5kEyN0pL7cDiNkTH5g72JUm9yskXoIcEuN3kZ/oU0OBKdIbTI9C//OTMRUytnd
	g7y1JIPynxyu/fri5yr5gRDEaBZtL9tVpc3CWg2uQVl+z3y2Exdwz8J6wExnJxxpYok9w81lMUJ
	SV7zG6TpawnAZ7nwZuQ/dalctHPS3iSaXtTLpr+/B3b6taD5i5tTjDu1mxGnTKYKb/OYXz0FkMu
	e/O7B0il7GX3Ilt82rbHAjsNM/gUdUzL0V1sLJCp/55UKng=
X-Google-Smtp-Source: AGHT+IG9zdVilHknM+0G6YXDighy5AbQ0VbjqNQ6JTiB66RdlK8I0yBhaHfW/+EquzwqjcR1Z+eYVQ==
X-Received: by 2002:a17:907:9726:b0:aab:f11f:f360 with SMTP id a640c23a62f3a-ab38b0b919fmr2405778566b.2.1737627086471;
        Thu, 23 Jan 2025 02:11:26 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab60d690232sm465042966b.37.2025.01.23.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:11:26 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/2] pwm: lpss: module namespace fixes
Date: Thu, 23 Jan 2025 11:11:09 +0100
Message-ID: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=0t2qfd3GnssXmR2y8LW0cKG7GonvDxo8t2BPTONaO9o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnkhW+EWT/d9tAECnBYMsK/F6iuh/aSQWrX2qOu HE8XJk4qM6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5IVvgAKCRCPgPtYfRL+ TrtwB/wMftkBHCMhEbdpGMmqUw3A8iol7rVdpIw048RDkshdp1pSwvdqW+VfoYJoBnq3AutVkN/ GaVl0al9X8ZTVqpsc7ZrVupNrQI5c51VubEeZH1snRTTWBKxLQAsRCqTD4v4WlqpVB7xBEIAqYH JqUVqzj+I9JHKbuofVsAFhvUd/5GY9IFgyhR2cigOuIrZ5YiqmgoyXly3wuY6RrWctcNKzCX6Iu nNGHLDhnxzpfoqt1UjOWppUoPIl+Lz9ZkNXBYCu/FRp8/bHoe+7opMmsbjmC3Cjo4aFdIvmp1QF lg5pGKiOg33nQppszYp167bJKz03GjoAMDJFzTxVWwcIVI0G
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

in (implicit) v1[1] I suggested to move the MODULE_IMPORT_NS magic into
include/linux/platform_data/x86/pwm-lpss.h. While I still consider that
a good idea I was overruled and so here comes the variant with the
explicit MODULE_IMPORT_NS in each module that makes use of the
respective symbols.

I don't have a fixed merge plan for this series (assuming it gets the
expected Acks). Either way (both via pwm, both via pinctrl or the
pinctrl patch first and the pwm one in the next cycle) is fine for me.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/cover.1733245406.git.ukleinek@kernel.org

Uwe Kleine-König (2):
  pinctrl: intel: Import namespace for pwm_lpss function
  pwm: lpss: Actually use a module namespace by defining the namespace
    earlier

 drivers/pinctrl/intel/pinctrl-intel.c | 3 +++
 drivers/pwm/pwm-lpss.c                | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

base-commit: 232f121837ad8b1c21cc80f2c8842a4090c5a2a0
-- 
2.47.1

