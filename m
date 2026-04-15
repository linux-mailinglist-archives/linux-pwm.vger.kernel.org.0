Return-Path: <linux-pwm+bounces-8589-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLVeJkan32nQXQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8589-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:57:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37F405909
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D95306DA47
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868C39526B;
	Wed, 15 Apr 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XVFWjk6k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A1175A6D
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264633; cv=none; b=SJDIfp+oth8ZXRqshjVfKMzR/r2fGwYEOOMJfpA0tMYvOguWS9vyUWa2L0CZ1DMJm4ofZHKP0vHn+1X+FiWrpFma5DJEXBnEzK+ztJHDMqY9bKNE8KTPsUzB9q5fwClsuMDKo3KM/9HKN8y7S1WT6skge/xdgLe0QsVfXMybEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264633; c=relaxed/simple;
	bh=Ev/XoHpc/zuPC3jNLuLXs/GGVRgRWnbEC5JNIWTtnCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TWGgC7/47Wh0XJg1GY/mjl9IHzseftMMIAnUehRSKNtVoDdHLlJr9LpkuRBzdJKOfvf6wMlMxhaFyYXWXpR4Yo8Kdo1AGcF4ANpDEK6uq+MMobXMLqVkTD3srA4+9rrAdziHGqm6k58q9XZrzUWAWjAN7rWwajDZaODeps0MDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XVFWjk6k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso6366736f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776264630; x=1776869430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUfEqAnWlQl1ZqiKV3YCAggYCvmAvG9tDObdHVC4vFQ=;
        b=XVFWjk6kJRGRnAFLsUu83kb3c+/cszr+v8JnXIz1fMBRlaZR6AVswkWHsFuR7VX4EH
         BSLN+0upln79Mw84HMqPex1XVNW4O526uODNrT86+9olCpOMqcN3xJRLMRv4WefBSS7Z
         dGjtc4lF+SGNi3QgcDi2b93DACqDObbYC/bt6R2IeYwjdRGmQmT0pytfOLfJ+MGoqc/9
         JD/7ZdDmQb/0d5ydwkuJiMUj2kuPj3zE3nlj4jiqBVPiRSWU9P1N4EV4Tmfqfv8EwW9Y
         hc/zje2oYASaBqv7+Bw2cYqP5az7e7+01JHHRfJCC3VruJEBciNCN25lVcjqcvtTumEU
         QvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264630; x=1776869430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUfEqAnWlQl1ZqiKV3YCAggYCvmAvG9tDObdHVC4vFQ=;
        b=o2ojo5EzwSfFY7Ixv3giBV8rLndN2zGx1R5Z4qjSeEhA5+9Pu7JvLhV6GIhWBC4A/h
         ulc2RwvrVopktK0f3EiWoyzanQ2u/mZ1fXCAFJw27CMLD2ZhHobWSJZJcirPr7j5iqEy
         zCtrPTftcN1p1wvBVm+wqdD8zu5YW6oZ0KLiUvWpuHpCJvIXVigpr2roxC5clJpHtXEO
         ahSjW8EPNNkT6pDslzHABECFQVHPdyAcBNQJH8f3Q/shSsZyJAUKJ6MFVO0CkREjjkjk
         JWcyUBIuL+221hjEqaU2j2aGHN4eBxNTMX+uCjXX+zTSPJ2Y0jpc5OL8n3sz8px4Ex0x
         NGvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lkLsxQhKYIIgZvTn16cdXGyrwvQ2lnqKR+VJ7cjjYtoyGKGDB/6bAhqmEPnG8U+N+yTtYFCAN9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa1JoueGghqZNoLQ8p5HY9TEK4QMoUEdDROptoUK/gMy35jAI
	TmKGRx7RSwjbYt2DUTA3S8BUZP7UA/7rx14YCk9VQToDTa6mXuP5R/hqtfKbqgJU4/8=
X-Gm-Gg: AeBDietBdwDgeMF+StpMWlQhNFJMLANqdsXwSo23Za/93cTOBwl9j5HPxK/2esRpDhn
	sPevrY8zyWesxdjWC+JYPYzg5jZGzOaNXtpfvkxL+FNY9z+0xAVZb5tmN8dVlYNwnS6eoyV+AdA
	Oi00gC1gmrFQwQ4jO/vwxwc+smcYJR03JimoZ2JeOB/DE2X+AbPhrhrSyp2Uq5Hybq8H8gZr/l8
	jfE7j3kmxx4CrNyAUz4m8mEe3PFI2dx+4rYkNpwwvaEQVLCfdXd/aZk7/MPRNrQULs7q16KlqrF
	95SDU6f8HAhgZ64o1vx6UvvM4tTeaK9inHaKcX+bNaOZU7EzknIEaNqAB3DNUi3QkuWtkEBJjQ8
	5NGcPNbPDOhlIzUp8ibcH6LO3v7qIl5L76kWysjj9vH3GuXoa0ZgPBOPPqs1O7bBDQF3KuJqTWy
	2uN91PMBmvLdOgUaadtTUKk4DTuJv8s1iv4TEy6EEcqMgMppxmKPJGHm9/6kPYJ2LnZReYYw8fH
	LCAJTCzpQjfVVs=
X-Received: by 2002:a05:600c:796:b0:488:e7e4:8425 with SMTP id 5b1f17b1804b1-488e7e48437mr87884605e9.23.1776264630228;
        Wed, 15 Apr 2026 07:50:30 -0700 (PDT)
Received: from localhost (p200300f65f20eb084c777289617ec110.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:4c77:7289:617e:c110])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488f4352af8sm1813025e9.0.2026.04.15.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:50:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 0/2] pwm: stm32: A rounding fix and a cleanup
Date: Wed, 15 Apr 2026 16:50:11 +0200
Message-ID: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Ev/XoHpc/zuPC3jNLuLXs/GGVRgRWnbEC5JNIWTtnCQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp36Wjy7gOvxddwOd586qrs+Qr4Imv1lEkngzDs a0aP4AneEOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCad+lowAKCRCPgPtYfRL+ TuWdB/sHjGdz6bLApfg5wvD90asOZlq5wB95iiT/6qRsVYZNCaJZvEINb9YE4OEuA2dTiBjambl b6WdQWEge1t3Wo4OZ52Doxb8A3k18jC6nvZOptwlnTK91Q9fXC8RNq1J1ozziVeRfXq+dAI7HMQ 8en5ZtFdJ/DF9/q9wIZtpXjPVJwQ751TKrA98Lqvjkbs7kzbrLqnVOHnnAcolIoxzP5+r14HpY5 EsoWfhrDwAfycXsU8De7046F6a+uS875tdeB+Lx4Ehcf1MgsV8b/378tlBM4AE/iZI2ic6WGgu6 /RnTXNof99lHnCe70yk1qU9UXAZew5PooAETyvnRFB9uMBBm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foss.st.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8589-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD37F405909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I extended pwmtestperf (part of libpwm[1]) to allow testing inversed
polarity wave forms. I'm not sure if I should like it or not, but this
immediately showed a rounding issue in the stm32 pwm driver. This is
fixed in the first commit.

The 2nd commit is just a cleanup that I have on my todo list for a
while. This required the addition of mul_u64_u64_div_u64_roundup() which
exists since v6.19-rc1~70^2~90.

I intend to send the fix to Linus before 7.1, but will give it a bit of
time in next before. The cleanup will wait until the next merge window.

Best regards
Uwe

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git

Uwe Kleine-König (2):
  pwm: stm32: Fix rounding issue for requests with inverted polarity
  pwm: stm32: Make use of mul_u64_u64_div_u64_roundup()

 drivers/pwm/pwm-stm32.c | 49 ++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.47.3


