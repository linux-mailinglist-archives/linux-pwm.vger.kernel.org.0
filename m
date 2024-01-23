Return-Path: <linux-pwm+bounces-887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F027B83873B
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 07:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FCB21916
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 06:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCC4F8BC;
	Tue, 23 Jan 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PiwrXaIk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5A52F9B
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jan 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990676; cv=none; b=tAuHJLJGev6//qq/h6wMZG7uYEzC5zvSiNTpb5nhgXzHgFALxYzZEkyHc5KznRGZz/jLz4j8WVe7k/v7hWecO9jxhKnIOo3iVIuORYbY9az+Bm+oHqfdi+im6BkC+GNR5F/apkXWRXqliDDELAMjU4a/+aGnjwzcBlGzo00Gb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990676; c=relaxed/simple;
	bh=UGJrbkAHZowjpbDbSbyvXnuJLZIcGdBZhwal+HXznKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlozuOhrXzQVH6WxP2IE463v9l4o0TSu0J9xKz7m7ld+3iYp1vOQAlXRPNu/F6CwNn05C83QJvkZ7Kt+BF/wKSVSFslI9NZU7bLJ8f9eCLyaGCthgki9MG6i+AbuKvtMRenfzzqJLILKmEPh5IqTy+24dYsX/mdniYIXLXxWLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PiwrXaIk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d76943baafso6294735ad.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 22:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705990674; x=1706595474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W628e97+8K8Qrf9wYfOHFnlYYn9fHGpqJ33Tr5gjMUE=;
        b=PiwrXaIkoIbA9kx5NcTX9CHof0d/l1SCd7eYwjfpkqCWp+GUSVsJN6tydFlZ9M21eJ
         mbVnKpJnEHNCH4RX5yQ2iPwN1NrkwxxhBz/23xUZhM22ISmQQgVQ89ATAdRK4Kx4UuVP
         v0tDvqqC6dEyaacoOXJzIJRvQZNZ3srTTR5etLMdpJUCNgAc2hFytYNqVCzVrtqr6YGX
         i6JnlRNY7tNJ1gWjZbgisO8mUbI4b8HwWX4hY2+B4kIcokFkoyIv9W75lzCKTtrCbwMm
         NeMaPMgnSKxGqtoBgwFbWluxH85AOYbyt/m6K+J4ypDZRvGDs0FaXRQWgC6zFfV8bWiN
         t8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990674; x=1706595474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W628e97+8K8Qrf9wYfOHFnlYYn9fHGpqJ33Tr5gjMUE=;
        b=B3kIQ5Wao0xqdG7K6f4bAp1Lo/eIONZqm7JawDvgHU/WH9rzLsUKM9pf+7MjcYYNox
         vQCCWTAG6WAf9ZUzf5Qwl4aHhOKjU3TX8rYZGxEB85cANZioR+Y42DE7J/qEKmt/eNgi
         x7LNf/P2B8eUGwRILOo5IPid1KXJXUiSb4GcgqMPT2wzfZ7SZdTJRtZ3IybSl7I0jmn4
         Tm5nVPjbJPZUvSrcZvGw95AttajHn36S215E7Q18kmd7BZJqH/8lF7DGREpm6HdDLQ9S
         s0AtqzUktDHfyKNs/4/KcCx6BzsG15EKGRo8axQp70E9YgtTXFdGgB4DBr+4A4UqK7qm
         dVhQ==
X-Gm-Message-State: AOJu0YyNxCsaTt2krH2qnF17FOgeMrkcS9OeTh+a8IScLZzxf4kfotEV
	2xLnoPJnYzxqpYbgXcRl/R7ptnP2JwpFx6vTghgobbTw8FzdnDcg9vkuphcIotU=
X-Google-Smtp-Source: AGHT+IG/CajBTbtdN19tZkW57mBY+kgSSzePajq+2Gcg5rqABA3BJV4YYS1ra1GHAIYzkn/TP9yhZw==
X-Received: by 2002:a17:902:c409:b0:1d7:4242:81d5 with SMTP id k9-20020a170902c40900b001d7424281d5mr2337974plk.105.1705990674462;
        Mon, 22 Jan 2024 22:17:54 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001d733c88646sm4425376plr.216.2024.01.22.22.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:17:53 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifve.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v7 0/3] Change PWM-controlled LED pin active mode and algorithm
Date: Tue, 23 Jan 2024 14:17:45 +0800
Message-ID: <20240123061748.8844-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Updated patches: 1
New patches: 0
Unchanged patches: 2

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v7:
 - Remove active-low strings from hifive-unleashed-a00.dts file.

Changed in v6:
 - Separate the idempotent test bug fixes into a new patch.
 - Move the reversing the duty before the line checking
   state->enabled.
 - Fix the algorithm and change it to take the minimum value first and
   then reverse it.

Changed in v5:
 - Add the updates to the PWM algorithm based on version 2 back in.
 - Replace div64_ul with DIV_ROUND_UP_ULL to correct the error in the
   period value of the idempotent test in pwm_apply_state_debug.

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the
   requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (3):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM controlled LED algorithm
  pwm: sifive: Fix the error in the idempotent test within the
    pwm_apply_state_debug function

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 12 ++++--------
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 drivers/pwm/pwm-sifive.c                            |  9 +++++----
 3 files changed, 13 insertions(+), 20 deletions(-)

-- 
2.42.0


