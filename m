Return-Path: <linux-pwm+bounces-5337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E1A7C884
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014C1762DB
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236151D8A0D;
	Sat,  5 Apr 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f8oe5KuG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF761CB51F
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845261; cv=none; b=gf0aeOdVUMt4sJBVK5k5kZRmhs8rZDqskg96I68wpne1WGv3yQIPUOzRUttPZL+wK1LproQXtCfR3rdUfFOwGG0sRDPwqmupkC0PWuz77H2W36wL+tqKu8uJLWwqZAY+wnJ2LUxoZDTGYFJa/sXg/RjjMoEWmvW1R74CvgRMPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845261; c=relaxed/simple;
	bh=SdTjxolhxMdpEMLdv2bok/HJQZH5YHyXLZcK4xTHZec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCP+dNDa0PIjGEeuZ1c/3o2LoFimBuRCd6kULYPAXtZQpKkGs2qZnlDgQ1aUQHgIhMp6Jz6qvdp53/b/CWpu+KqiyHXqHXm2CZiyIs6gmQtK/MKXIeUdnoLhrcR1rxM5xF9rjNdQW02k5iPsbajZOvHSiD7WHU5NjE8kuvjdrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f8oe5KuG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso5178766a12.2
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845256; x=1744450056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QgniJ6UdmWL8To9NYgCLVFTHa10nmpPKSIlfTFU2tU=;
        b=f8oe5KuGorMguiFhBIf0tDLKaA9DQqdvfhkOei5wAJCxhJLa/YkAaLKLuLm2en6XNA
         t0XGEWdNOC6KrF+/OvP2IMcLuOkN0ujAdkr3ODufuOzcDR5d69se5ZfWtA+gVmk6RIhC
         La9i3eS3iBVeiB6MNpOJ/B/egCp+heXmyTszzhk6Cpg0nYRP/yWn1E1AWWfgJsW7awnD
         RHBXpQR6xxLOvoA/wRFNHTF3esQcWBIJTPAsXTBnDaosgs5nRqbKDu61P/eR30Md/s6B
         u2Bl3pwOfhRpV3qW5881na9PQFIr+ezbvibtR9HwazvwGyAQktqoEZMXA+SRC3z/9dWe
         jIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845256; x=1744450056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QgniJ6UdmWL8To9NYgCLVFTHa10nmpPKSIlfTFU2tU=;
        b=kZAFkPhg9MHYLcwuClSqenjjv4DQ47nvfWrLbs2lWzB0mosrg0W33AG4zchUaT2Rh3
         fUI2peNVotpcnGwoYzoN3Ke5otwssOLGybV3DaSk6Rd9vTUH99AmbXlL1Q+vcuVqS4TE
         hS7snx5uYSQJBPDawYKqVOsssM5ImPS3gfGBwCm+amidUsVXh1k9YXJUbVqRaUPZAQ+I
         JTUjeHUUT2CB/7aHdbdZQXm2amsZ3uxYu3UqaY+530l1lWTJclxoWkjID84Jl1y4Tfwa
         ewcT057k7UBQKK26mwluT+ytKAFWpAAuVHtad/frjCZF1H6mNfaHn92+7av/Da+H4ZLA
         VikQ==
X-Gm-Message-State: AOJu0YxPW1Au6Rd49v6pW6VB3VmoaDZBgYBByhIGTNMHOcrTGV/l7+9Q
	+P0GQbnzZzEsn0GZymY4yzP/HDkwHfd5jn5xGjbzXNa2xD8QYZvX+mKuIaHzf6++3Z6eJfbwAwP
	g
X-Gm-Gg: ASbGncvD/tPPRDo9lZ+ynszNMMYdbwkfIRfwMhrNouVsTl3+ak+nOsXTwS28bRLezBh
	0zHjndrcuYh0WZycKq0uaF6Z6LOX2VTcLRf0ihhyhPA9pWc7GHEgbZERXm/QQkuYkjs0mYDIKRY
	bwFNHCqscFYeAeAyJIwFntOCfJAHMNMJ5MOCN2TG9QY49XP9jijCp5er7AohnygwkfXU6Q8L4eL
	AbJgQlBXe2sv+ottBe7ZmFQCYRihNNaGEnyGxmyjcOnaKXWIl9l6xCb/MAgOueGtFKOiG+YpqMS
	rbc6EYBzzYLZF8jqzsEz2as0fsOLduia/7VzA2DehKF/1ca9+w==
X-Google-Smtp-Source: AGHT+IEbL8c+JGzPbn45puOitVnDeaHIThpApjBbi0QC6iao2fwFoA3sj7pZiaJmhvJQOzAGSNO8Mg==
X-Received: by 2002:a05:6402:280b:b0:5e6:44d9:57f7 with SMTP id 4fb4d7f45d1cf-5f0b3e4732amr4711403a12.26.1743845255834;
        Sat, 05 Apr 2025 02:27:35 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f087ed1f40sm3442815a12.26.2025.04.05.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/6] pwm: Some fixes preparing chardev support
Date: Sat,  5 Apr 2025 11:27:11 +0200
Message-ID: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SdTjxolhxMdpEMLdv2bok/HJQZH5YHyXLZcK4xTHZec=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvQP3wue3FO2D7yoPyX3tFXWCtPSC9wxXg/6hGTMVGZbB hUsSOLvZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAid05wMHQGvZ3cUu4YtHTp 6coW45J/V5ef4p8hFa0cvPZHwTankIZ5zcd8X3KV8W84vpJ5YuP6zPN+y88nLy7l0rM9cTnLuLL G9WP4rv+Zdsb3XjxQMVAW9f434WduiGpiv0aE95O5T7uZZdvK018/ruj1KZ8/V5DXo1la9VhDeo WpifGV+IOPl7c+yAsWdTY8WLbKvITd6Gy/u5Yi644lPVpzN8zxZt5i+P/zp7dX91xz9WTX1bK+p cu+IOJaaHvGkjkhBT0V6rM6e5jK8kSW7S57pxZz4oXsBE8nxqu1joLhd8+JX1m41p9XW9U+ba9B 0fzGfZ32j64rr7YwizpmKp1fVFSz83yM3/11HQna2zcAAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

while working on character device support for PWMs I found a few
inconsistencies that are fixed in this series. After that I plan to work
on getting the character device support into shape to get it into
mainline, too.

While some of these patches qualify as fixes I think there is no urge to
get them into 6.15, but given there is a bunch of such changes I might
send them to all together to Linus for inclusion to 6.15.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
  pwm: stm32: Search an appropriate duty_cycle if period cannot be
    modified
  pwm: stm32: Don't open-code TIM_CCER_CCxE()
  pwm: stm32: Emit debug output also for corner cases of the rounding
    callbacks
  pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was
    rounded up
  pwm: Do stricter return value checking for .round_waveform_tohw()

 drivers/pwm/core.c           | 23 ++++++++++++-----------
 drivers/pwm/pwm-axi-pwmgen.c | 10 +++++++---
 drivers/pwm/pwm-stm32.c      | 25 +++++++++----------------
 3 files changed, 28 insertions(+), 30 deletions(-)

base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
-- 
2.47.2


