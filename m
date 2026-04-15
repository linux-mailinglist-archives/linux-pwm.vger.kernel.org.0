Return-Path: <linux-pwm+bounces-8588-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNTGDDek32miXAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8588-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:44:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA440570D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36F130CBB5C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED303D412C;
	Wed, 15 Apr 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ydtbJb7h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A43D3322
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263870; cv=none; b=S+7cZ3C9EviOh3nGV6/Zr3kPFK9/5rxXJtDtZQQ7Dvv5fNHpP/oG7nWtm4Y7t/Y7svoljD6JXN+DajW3katYTpJt1vr+6B3iKffd0HsMf9mnSYm4cabL8/4SXu8JxgEKAJj5rTBWZwv4hMZm8Iyy98d3zM/xcJW2iNn90n6Hjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263870; c=relaxed/simple;
	bh=LfIjyYyx/IBzVebqbxiNT5LiUQSWc2N9K+ipy/DWAZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2EflMm6tzxLbes5j54bWssUlsMM/eA8d+qT6bI3HaXZN0e/2dmdAmseRUAukqq1t5nnSGobvwyRBETJWeui40GeBD7vuJJ05PbyX81YhnJknUFfS/t2UpGrDFZMccyVaTOJTOggckWqlOS6P3m60qOutSxC9hNzCQMuWBItLU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ydtbJb7h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso113066625e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776263864; x=1776868664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klFDyUaS6A1zBMNDfZ0ty7X4uEZ5w3VLCL8oBFl7J5E=;
        b=ydtbJb7hTDVmE1Dz+TNY1CQjBzvHsLkWZ4dT9YMwAJQFKncbM0IxABezwj6Oo45d77
         WfXh7F8OFQmWfucEf8ixEDnOPGiCw52MO2wLteW9bPmzKKKQ4W3l9UUH5VPHftKieK1Q
         qU/uMk8SBN7eRQy+9IUHxXkRMpOtEvi0VeEazdzCBsBtVPHt0/HtOyinFWa2a9JCL0yW
         C6aDyH+96iVnjdL/dvlzvQuwJ8yWABi/M6vtFlGbwtgiAby60VNSXBHWKqJq7ChcCY8H
         VfJ+8fBW3JscqKJoOteJxxRVcb9FvrqtT2YffPTcZr8z01VC5h/r3YS+fWNakZBeEKgE
         WOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263864; x=1776868664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klFDyUaS6A1zBMNDfZ0ty7X4uEZ5w3VLCL8oBFl7J5E=;
        b=ZNepi0mODM4LJQz586uHyBIKwVO6GgVogV1kCy1f1aZF4qEXCSnjDnBT9d95hj7QTl
         Gfg2lvPL/prwbDKjAdHw9ZqQMcq58eFy17IDk+IWHfSJbBiCDdmWrzSHYlCIyuiC/bIt
         gVm189yvFEBtvC3Emo+hDZeYwwR12hZHoBf0xzt0CRiMoPCMtf+GVoHR9OYFcb809mFF
         jmeamd0C0+K+S6xTNOgsDQMeHrM0E1I2km4mQxQRsnt5HFDPPh0r0xsR6oYV1xChZ6kb
         g/FBJ4UDLhSkbwIFXCBpxX7g5ptCw8TQTb2PMajhxUPWbRr74Po/ro0uGt83tYg4ut0z
         /YNw==
X-Gm-Message-State: AOJu0YysgXCFDTgRPcZmXBIXE9C4WLTER7gmnNeTgGy1+kLswzPYzxAS
	hCfy+6t8bK6uOOwq3AknCfz0TGc/9aWSkdJLeMxK4x/uWLG+2xxRNSPF4e4OgFsMg8oYSEOAsdE
	5ZUzY
X-Gm-Gg: AeBDies40sg7vYUGEKpim36hzGSXIUeYhkHE0d4z+sar7C4ciMDXK9EKUvm0DIxh/+b
	G+nXmelIlDPXBFqAZLPT9YpRdCqKnbTxTbdD6OF8aSWxYPBYxiJtatXTti88hPhRufjt8fIEUIj
	IXG3K+TcX7HSw0wMJBwLjw6WmZsYiXHL0R5pnER/bZyQ4r+lJUVptkXzAio9u0hk/y6Mh6/i/Wi
	Ri2YLXRgzTI2Vp1Gg+qJRVguAaEU+n0zNIYOIXswFc71k6xijV5Fv/PyG/wzWg+6qqXtAOnaCLg
	0kYh1skeUE0BbDQlBWDA2w5wdIb+G5heEAZIAScMtewL3zgbJ4p77fcVIXYTbyy3MxyZEWw2WsA
	nuib34G0hckbZSCv/+DHpqb5NSEkgDY17xUP0dOIVx5I/k039NeBFRMk6kSZknSRhrGksaPtmCB
	Lc5zJAH1q4Mt/3iczH1sf79VNWCcGHIY1zmXI1MrESX1o1IYXkENu3QenOZ9zG0Q+DnKzHbHZYS
	Q8V0JxoZGu41TDvUvG5wBKnbw==
X-Received: by 2002:a05:600c:a311:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488d68607fbmr227578655e9.20.1776263864108;
        Wed, 15 Apr 2026 07:37:44 -0700 (PDT)
Received: from localhost (p200300f65f20eb084c777289617ec110.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:4c77:7289:617e:c110])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488ee038752sm139796925e9.9.2026.04.15.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:37:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH libpwm] pwmtestperf: Implement -I for inversed polarity requests
Date: Wed, 15 Apr 2026 16:37:25 +0200
Message-ID: <20260415143724.447340-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3121; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=LfIjyYyx/IBzVebqbxiNT5LiUQSWc2N9K+ipy/DWAZE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp36Kk1sGFVjHggig6sRmR5jT+wrWun3Z4GddvR TK5xONajAiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCad+ipAAKCRCPgPtYfRL+ TugzB/9Z72ejKRy0vDGu3ecChs7h3QN/GTx/KL6FZQ+0R1HZecPReUeRYcJK2CO4iSMtcQNr5mD IA1kb9h18DhmYDyF79uMZO8/vesWZzVsfr9vjRGuT6+nujjZIwh2hXL3WyYBYkNfVV7pP7Txp+h yzf2zk28yASHIevOYAgA0XZ7qeUyBFy1DwKwQU1fNnOSFn142GztKcbsyXmElU0Qro9yMS0MMfW Hir5eG/LtZad2uehcvczyRClo/ml242LKBYmP6CA1eqoW0CjTTOvCadZSeTu3mLIJv0+wEhJZF+ Y5lmI53GyPy1xeBipsrItWHi8tafTYwJRqXNLv/U4TBLqpxh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-8588-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: 82EA440570D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver handling for .duty_offset_ns > 0 isn't always trivial to get
right. So make pwmtestperf capable to do some tests with a non-zero duty
offset.

Fix a typo in the manpage en passant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

triggered by a driver submission by Andrea della Porta[1], this increases
test coverage to (hopefully) catch issues around driver handling of
duty offset.

Tesing that on stm32 indeed found a bug, will send a patch for that
later.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/adkrHkANCzxO8KUP@monoceros/

 pwmtestperf.1 | 13 +++++++++++--
 pwmtestperf.c | 17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/pwmtestperf.1 b/pwmtestperf.1
index 74dc8e30f32a..944564c14a0b 100644
--- a/pwmtestperf.1
+++ b/pwmtestperf.1
@@ -13,6 +13,7 @@ pwmtestperf \- Applies a simple test pattern to a PWM output
 .IB periodlength ]
 .RB [ \-S\~\c
 .IB step ]
+.RB [ \-I ]
 .RB [ \-v ]
 .YS
 .SH Description
@@ -27,7 +28,7 @@ and
 
 The fixed period is specified by
 .I periodlength
-and the duty length is increased in each steps by
+and the duty length is increased in each step by
 .I step 
 up from 0 to
 .IR periodlength .
@@ -35,7 +36,11 @@ up from 0 to
 .I step 
 is negative, it decreases from
 .I periodlength
-to 0.
+to 0. With
+.B \-I
+given the duty offset in each request is chosen to describe an inversed
+polarity waveform, that is a falling edge at the end of each period. Otherwise
+the duty offset is zero.
 .
 .SH Options
 .
@@ -68,6 +73,10 @@ in nanoseconds defines the length of the periods of the waveform to be set.
 in nanoseconds defines the step the duty length is increased in each step. (Or decreased if negative.)
 .
 .TP
+.B \-I
+Use requests with inverted polarity.
+.
+.TP
 .B \-v
 Emit some information during runtime.
 .
diff --git a/pwmtestperf.c b/pwmtestperf.c
index 72abf3987459..95be2b6fe64e 100644
--- a/pwmtestperf.c
+++ b/pwmtestperf.c
@@ -22,16 +22,21 @@ int main(int argc, char *const argv[])
 	int ret;
 	int opt;
 	long long step = 1;
+	bool inverted = false;
 
 	unsigned int chipno = 0;
 	unsigned int pwmno = 0;
 
-	while ((opt = getopt(argc, argv, "c:p:P:S:")) != -1) {
+	while ((opt = getopt(argc, argv, "c:Ip:P:S:")) != -1) {
 		switch (opt) {
 		case 'c':
 			chipno = atoi(optarg);
 			break;
 
+		case 'I':
+			inverted = true;
+			break;
+
 		case 'p':
 			pwmno = atoi(optarg);
 			break;
@@ -67,6 +72,16 @@ int main(int argc, char *const argv[])
 	}
 
 	for (wf.duty_length_ns = (step > 0 ? 0 : wf.period_length_ns); wf.duty_length_ns <= wf.period_length_ns; wf.duty_length_ns += step) {
+
+		/*
+		 * .duty_length_ns must be < .period_length_ns, so don't invert
+		 * for .duty_length_ns == 0.
+		 */
+		if (inverted && wf.duty_length_ns)
+			wf.duty_offset_ns = wf.period_length_ns - wf.duty_length_ns;
+		else
+			wf.duty_offset_ns = 0;
+
 		ret = pwm_set_waveform(pwm, &wf);
 		if (ret < 0) {
 			perror("Failed to configure PWM");
-- 
2.47.3


