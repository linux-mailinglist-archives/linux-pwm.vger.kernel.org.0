Return-Path: <linux-pwm+bounces-6791-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6347AFD546
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331FA188CC1C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835DC2E5B02;
	Tue,  8 Jul 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LkaDvDtN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D62E6122
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995485; cv=none; b=VaittyfecQNF90y0WHpBuXfK/39xRjB2zzgfUtY3oA3VBUh1MBmeH3bzuf3x8ZFDqPnpvvPIqOMGHmE7eDEW6q8hJw2Yj+cK86y/SjzJlZSxEdCKgv0az711C7vrnwdbhX8/5RSQS5gdLN5qihBitGqTrQTLckxzgXpq43W3cIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995485; c=relaxed/simple;
	bh=xqnuXLXoSSSVjXwhnbifuTr5vtYRbS3/FfT/9L1UqUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D56qDBaY0LKWID2cloHshcWVNLs/Qmrbj/s47XSTvcW/94wcFd1wFe7SGJ5u41/pSqBzX0aDwHjH/vuJvU0lm8R3qFS1iYuLo6MfFgOOZO5VbVDGBsETEb5RcIMy+KbVpJCSn/IpcGO2KSVq3vtdKGSskxF5iZC4t+LUSrNqB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LkaDvDtN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so819689066b.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995481; x=1752600281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKPhcByzaV9eXNIanyp31b1SrVpJrifPMqShaa1jNnI=;
        b=LkaDvDtN+ooOY9ftn9IP5dikTjJ5NFArSXXI5zxUbIEvRGdrDlyTz/u3so10zKFuPw
         MCDslLK9wAhW96BnxI+ICOqjeQXv71l7Mnqso69RJbEAvuqmdpE2Sc47WXfLf0XlbAWr
         aYEsCDCdev1dILuHOW4xLYvdLRsnjZRK41wum7asHCkTbXRuTposOI7Lz9cwrPvRdTV2
         emjo/Bo0x6Zi0wgvlmYbDz0J6iB4ai+xzIEuRvBWkvfiJ9txHyS9VJ8nIVTiFzvpWzXj
         f5xjFCvm/TOJAaqcbd2RWmjgqd1zWam5UbtWWjmvYe7tAMPr9fKZIdnWF5Xl4Rg9GMvE
         nLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995481; x=1752600281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKPhcByzaV9eXNIanyp31b1SrVpJrifPMqShaa1jNnI=;
        b=G8E4TuP8DbmgU9G0rVEfIQGTzr3M8SRPJft1CUwD2RlzNYAKioCJJgr8JiSdj1cko+
         mhwuQ0jVAs3mwVSsd3kxEoYkluCBplpnE6SeUnrjS9jSB3/4irAMeeaSfmvmebQycFXQ
         rWdzUP2GdA6rHTQiTPjW2McKtvEUOAXCRjIEtVHlaUHyePWpfKn74THO13UnBRVP4Hj4
         ac/KUIy9K/g65faaUWkn3FMU+5ducVKqSPjE/33rJHT9UwJSnjjuy/ComuqAPKcX8/Uo
         g7Wh/MbLJjqzq1C7xYKRI6mxtmBjLwLUy4yYXC0MNKCmaHM2+n5Lj+TBQaWRBASlVfVk
         SmkA==
X-Gm-Message-State: AOJu0YzWcJwmrGitFhgz4ZfDLcKitpu5grDPNhZ5YEBqj1jMHgc+QTq7
	WN8IclMUBUh0Gy6tO7NWD9EPTC6egPv5hPidhIuawYVjXKIsJUBBevNWH9wU0iYZHj33LWRU52R
	7EZJu
X-Gm-Gg: ASbGncvAuXm0WCazJnz1LQ7i17D5kOV46/21eMQpe4pxNW3cEEzC3SNF0mCURTZ/jSJ
	97tnw+YTWI1ASqZsOXrIbgYRFkgZSCwRf16hnaltbkuuA+tIXJ0PQ+f9Kxg5QfxhQ2nJIqEf8fD
	DOV3kZplDH8Dj5+ijyrtjLZDxN6AFr1oEppryxFJTIVmj0VrMDB46z+hwOORZzwI+Bu98koTW3I
	9slbrQlHG4nkIKXNhB88jcLGtRFO/D1LyD4QDa6t07H+CC1NOEE4iz3dTfOLyFcVWiiKGEO7F8c
	M52/FyMWNzMAOUHF/+H/9X1E4l0oopsCn09xV14YcGa3G3KX4Ovauz9YI7liQ3E1mDmgkPWQFR5
	F2SoD2fq64BHMXGaKrrvXfrP0JtUK
X-Google-Smtp-Source: AGHT+IFUzXLQTGHuq9SmnZhc3B6BZ99t7H9QhLxv9m9M93krXBbO4FYEcQPaT9ql0YOVmrSdFyy0Zw==
X-Received: by 2002:a17:907:6ea5:b0:ade:8720:70a0 with SMTP id a640c23a62f3a-ae3fe687bf0mr1797955166b.20.1751995481413;
        Tue, 08 Jul 2025 10:24:41 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b5e808sm937884666b.145.2025.07.08.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:24:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm 3/4] sysfs: Keep polarity for constant waveforms
Date: Tue,  8 Jul 2025 19:24:15 +0200
Message-ID:  <372ed9bf9ac6c45c651fae81f8be6f909a6b7564.1751995302.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
References: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xqnuXLXoSSSVjXwhnbifuTr5vtYRbS3/FfT/9L1UqUc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVRIc4dxyM1Hp+20cJcAj53CthbONmmK7XFck VMxsgqgw+GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1USAAKCRCPgPtYfRL+ Tu3yB/kBIqqfVQBtA6FHQ6bBzzShiejn3+OXBJooC7OS/8Um92Q6kfhVe0jucGcLGnO+sg+tMGu P1IfNIkpPHgsdhH/1qQqMuWiuGzzbD/h1OKtUmg3MxDgQRma3EbBWVpWwZ+SY20OVJQo26kGr3Y DZGOJgT4AXldtQOW2p3lxMhQIlxru0xZamk2e1sLt5YbuoqQuqVMZteLadiRf/qd5RurTXYdd76 gXffGXDdf5G5tC9t/IHbH5SYtd5Qjwbyht8hVWWzRu/7L76x8acfHMzcaNFqJ5UT02FIKUIeNU7 FOjKOmBtEwvr8iFd/WnOiXiJazWsl9bEahMGaSNkfbcO4mRW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Some waveforms have equivalent representations in sysfs with different
polarities. As some PWMs only support a single polarity, minimize polarity
changes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 sysfs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/sysfs.c b/sysfs.c
index 151b035f72d1..9eac066eb8bf 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -122,6 +122,43 @@ static struct pwm *pwm_chip_sysfs_get_pwm(struct pwm_chip *chip,
 	return pwm;
 }
 
+static ssize_t pwm_chip_sysfs_read_prop(const struct pwm_sysfs *pwm_sysfs,
+					char *propname,
+					char *buf, size_t count)
+{
+	int fd;
+	va_list ap;
+	int ret;
+	size_t cntread = 0;
+
+	fd = openat(pwm_sysfs->dirfd, propname, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	while (cntread < count) {
+		ret = read(fd, buf + cntread, count - cntread);
+		if (ret < 0) {
+			int saved_errno = errno;
+
+			close(fd);
+
+			errno = saved_errno;
+
+			return ret;
+		} else if (ret == 0) {
+			break;
+		}
+
+		cntread += ret;
+	}
+
+	ret = close(fd);
+	if (ret)
+		return ret;
+
+	return cntread;
+}
+
 static int pwm_chip_sysfs_write_prop(const struct pwm_sysfs *pwm_sysfs,
 					 char *propname,
 					 const char *restrict format, ...)
@@ -173,7 +210,26 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 
 	if (!pwm_sysfs->cache_valid ||
 	    (wf->duty_offset_ns >= wf->period_length_ns - wf->duty_length_ns) != pwm_sysfs->inverted_polarity) {
-		if (wf->duty_offset_ns < wf->period_length_ns - wf->duty_length_ns) {
+		if (wf->duty_length_ns == wf->period_length_ns || wf->duty_length_ns == 0) {
+			/*
+			 * Waveforms with constant inactive output have two
+			 * possible representations in sysfs. Either with normal
+			 * polarity and duty_cycle = 0, or with inverted
+			 * polarity and duty_cycle = period. The analogous
+			 * statement is true for constant active waveforms. As
+			 * many PWMs only support a single polarity, and also to
+			 * minimize sysfs access, keep the current polarity in
+			 * this case.
+			 */
+			if (!pwm_sysfs->cache_valid) {
+				char buf[20];
+
+				ret = pwm_chip_sysfs_read_prop(pwm_sysfs, "polarity", buf, sizeof(buf));
+				if (ret < 0)
+					return ret;
+				pwm_sysfs->inverted_polarity = buf[0] == 'i';
+			}
+		} else if (wf->duty_offset_ns < wf->period_length_ns - wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "polarity", "normal\n");
 			if (ret)
 				return ret;
-- 
2.49.0


