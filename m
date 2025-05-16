Return-Path: <linux-pwm+bounces-6004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A7ABA37C
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 21:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA97A073ED
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5052AEFE;
	Fri, 16 May 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yUZyQej/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC91C3C14
	for <linux-pwm@vger.kernel.org>; Fri, 16 May 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422946; cv=none; b=dOPLilJ5QRO6Vj1LECEzdN8jQLTXOEs5uXaPJs5wLy/EEe3hqyPu/OGQUv4pqvIW+OhECW1zUEh0ocbzsoJI0xQ0QTwZrzj5/ott8r46eNkSj4enyoP2DTYc8cKo0kN3mM8njxXXQOnAvn+fFJwLXPQePoxkoGJD7sovl4KvWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422946; c=relaxed/simple;
	bh=ygMT+zL/7RmSigcEVb/b3CNa1xV5xsIE1PTsd5t0jTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=chvBMZ+lUR1BjTeh1PHqGV1rKnWX1K5qlDImiQZm0rYkyWccaOzfaYRB7YihAbVGnSDE5LHK4Y37CsPQVgTunBWCvuDu5l7ha/YgAJ3wNdIKoNOkCKpqA9auotV+dSnP7r2ulTUEpTUxYsmyxfTyynOcsOrBdpiC5tMPwNaY4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yUZyQej/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso4718917a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 16 May 2025 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747422941; x=1748027741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JS6qE6IagD08xYDzBtHdMQXyST3qdstknQq8tfiqWTw=;
        b=yUZyQej/jMNQZqlM+zt36yZSCqGLMSeHh/z7uQcojQn98HKlye7oKMji19+lcm/XBp
         n2ShYSpX90oc+PDMv35iYYQCF3Fv1IgsybVLb9d0Ue4nU+H5OU8zunjlVENV5WHyqQIv
         ON7SUWkGruIKjdfUEc/76PbLkH0kjiAHrZVkQeBrGsH2Ge9ISa5PCq5tXmkDiuQf6uQ/
         YytHOJ456d4WLQmPmpcnrvvSAjxH3Dt5+Fc3H7k19E7HsPt/O8bfHmadU7oFjRuxZHpa
         F/yLvf9JVhFHK8/AOggzzLIxlof31KRLGnNIdepzLpL5CEIHXZeQD+cS/eY5GAZg/7J6
         KGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422941; x=1748027741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JS6qE6IagD08xYDzBtHdMQXyST3qdstknQq8tfiqWTw=;
        b=fML7zbFlmYbSMtxvwo0bUl2Y/NZWRux4rBx15IR4xmF2OYJ6TZv28F4mDQBSq9Y5xu
         O4ovhZtnv9SOUCmMRJEakfyYjNmXAJ/crK5KoyhkIB9xPL6oa/OKui2Zs00ZsYtgnuj3
         YqmV1m4WfljDLCqws6wYz1Sd0GvAIXSy5WbGklt65xA+Ce29NFlAJlKMgvJG2q6Uz4Hp
         bkuuOTJpCgkn59Lf0HuTKqNIkxy0M+GIaU9lNlKX+rPj+HFW5DN3AkyGnfLw2eYbmJ/o
         RPvOh/5TrWasVuH8lYIrajHZYwXPwVpmpMSxad6flAhTd9gyi8SjMNOTB6V0XA1FOBqm
         yJvw==
X-Gm-Message-State: AOJu0YwLiXja01XuDHNO3zS75nMA27QBZgbiFkdEwFlL9al6ad+qPIs1
	ceDedmPcbhzWK06TXH+OdKrUkBvkIgwIWNpjz4cbS1m0LdRdpkHMO8zORr7GAu0i5M+cQvKjILe
	PIpZB
X-Gm-Gg: ASbGncvuIVuWukytHIO/YLVjBvTvq00fU7bbKY7kaLfM1dRaNyJDLp6ngB5MZ2+n15x
	mAw0CwSPXMnrseFFynhkNXtq8DA3EnNg7Gxbq7mUTtyfhvHSLh2uk0zot7QvGrt1pDcaSaaVtNN
	X7koiCP/GRXP2CbBmj2w5rbEApYPFBYBLOmgGzESjvfBfLKqmZbLsuitWLb0rOE4hYAw0a+xKBy
	Zz7TxyxTb4tA2mocjxwnBXq+Tfn9yKUkX2S4vGHqtH1Usr2hnyGzXsZtpbXTw7KsdPY5iN91J++
	P/qczKdEgiJhg7pauVZq4oNfLdzbEOyqui42en4OZFhypug6ITM5h5hJ
X-Google-Smtp-Source: AGHT+IFKMBLK2XCvVRDB9NQMzP830gG09cBlMRxGe56OhDtPrpF9dD2MAxQ8BArK7IDFMaPuMlVvvA==
X-Received: by 2002:a05:6402:51d1:b0:600:7c6:eb31 with SMTP id 4fb4d7f45d1cf-60114087aecmr3274708a12.10.1747422940886;
        Fri, 16 May 2025 12:15:40 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6005ae48253sm1818859a12.81.2025.05.16.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:15:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm] sysfs: Complete cleanup in close callback
Date: Fri, 16 May 2025 21:15:36 +0200
Message-ID: <20250516191536.1353824-1-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unexport used PWMs and close all open file descriptors.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sysfs.c b/sysfs.c
index 3188c1bd2ecf..fe4edea1e102 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -41,10 +41,18 @@ static void pwm_chip_sysfs_close(struct pwm_chip *chip)
 
 	for (i = 0; i < chip->npwm; ++i) {
 		if (chip_sysfs->pwms[i]) {
+			int fd = openat(chip_sysfs->dirfd, "unexport", O_WRONLY | O_CLOEXEC);
+
+			if (fd >= 0) {
+				dprintf(fd, "%u\n", i);
+				close(fd);
+			}
+
 			close(chip_sysfs->pwms[i]->dirfd);
 			free(chip_sysfs->pwms[i]);
 		}
 	}
+	close(chip_sysfs->dirfd);
 	free(chip_sysfs);
 }
 

base-commit: 00aff52a76199f13ea9e0ad628ffcac93fdce538
-- 
2.47.2


