Return-Path: <linux-pwm+bounces-5327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD10A7A606
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A733AE6F0
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36824EF7A;
	Thu,  3 Apr 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z0NmPSdI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D472505B0
	for <linux-pwm@vger.kernel.org>; Thu,  3 Apr 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693113; cv=none; b=oBiwoLUeczD+zjW6AaCCasVKAlZ9cnbVfiguTk1lu/iyvT1aceD37godITADYNhesViOnlhBJt3pac0XoPl8l5fxBTQ9rnjjnMqpbB0OZXJ9jXb9h+d6ZtcW8PePEMv9Qgz2Eh/KeH1CUzq+GkwSX4t0S5g/d/7Wt6raJmd+Amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693113; c=relaxed/simple;
	bh=cNA+lbDCTn9KwfAUWg8VK4M//4tqdlt82Ex4ZpX72jU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rc9OxILk5WhNZuUH0IU+nMr3/laF0EQZ1KjSIAviUyCErqssH1haWVVk+XvyCjnmDMSZEKLxO2h22EoD0uD2k3z1jeQxoSOGI229gyxheiIsNuqFnHORcJ1oj6ZB8u7JTBa1haQCNgIAFdfWYWPysn00cEGSAJldCw1t1ke0Ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z0NmPSdI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so12355275e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Apr 2025 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743693108; x=1744297908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaDHxEsqQIT9hR4x9x5kbuL4P0dWH7jHY8ue1EHDnaE=;
        b=Z0NmPSdIHfnhsqBL062N+Au6/sGqg7tMSNbebK3Uu3Y+vs9lqqE7NysiyA/satvorg
         HCD8mwsDIEnGNu9ceiMkHpnbRyUagRBTE5a3TeMi+PjpogtjJZcbphuTLEAXFBcbydW1
         poiZ+gpw4t5pTP/SlUICnzGdiJB5UVUjQVWmjnb32DdyqgRblePA4ZoBrB/M7LVsKmic
         +6VgHZqf82PQEdAbhCCmrydbefGHAt4jY7vZfjOheVzDTfk7sShOg5ANZiGsuDFoLZkh
         zBSJzQbzv4a+P9kBNHpUcOzIWBUnq4Fnf3l+8F2v/kVyci0MmrGF3lvUJFO/WLRqoqqk
         KWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743693108; x=1744297908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaDHxEsqQIT9hR4x9x5kbuL4P0dWH7jHY8ue1EHDnaE=;
        b=gAjA/O99NXtYJiwU5AiJlLk4CgIvAayH0cAChf95C0I8mqKEhuz/35piwSbNfrsYat
         6kdTOyFIHgKZo0kLYl/fJ2Wj+58tO1pEpptcA+egJ/hGR5o2Fk0DOFuKDXElLBW3CapJ
         zbdAnaB7oIhBKzbkhHxWWgPf8/g1I9YhDlQs5riBTmaVyWG87V8HWcYfys15OZ9GBve+
         7O+47QyykeSXcN4ra6kWMUnd/S1PxcV7RTUsWjS2lJ4PprPPNrZbR98B6SwnhAvhibCg
         JLu6eQlwIqgvMMLdwuGQAj4JKWKIptdTsTyjc4uYksBTAQhylmakQ+9fI5j+Qo9k0wqY
         gcrA==
X-Gm-Message-State: AOJu0Yw4iP2mWgLQI9gchFxiK/xjUdjT5jeNZYrCLOEDnuerPxRAeFZa
	iaEmR0HBVah2yfEzK0AtilT+RX8Vnfmlcz7cLJ625QE0LOzrGgmHHTpi0LgknU9DWW0/eHbgJNP
	4
X-Gm-Gg: ASbGnctqksQVRtpB0ChAu6xRtB94hm8Cz76VvoWD8jKgklmKPsHn+sA8aGBu3dHCu3U
	fujddXe3NBXVN5lFtqOt7+hWUUUaVe9+vY1AHnn+YDeRH8vnW9UkB8HPe/KHjorEghvkIghZE3t
	O3AnClSVZKG9/BUqlDDwdXsqm4YQLln+JzrXW8wJ+rraGjCGi0Z+jn+AfYhJagNvDcbORqnn2D5
	s2F0i44OybWy8EWdpgimoF3tYpDjGkaSeoQOCz+tMF9m0036Y/RSBf6a1SuVXOg9Oa7b+hVevHM
	5/LK/ZmbmqzDDxpblSi27X541lxhr0/jFJk/n1mS0DvvsWM5tlW7uoYDvg7h2/qjmm+QwnXGgB5
	vWc6k9nDfInk=
X-Google-Smtp-Source: AGHT+IG7Y8dG+ndq1VnVxMOuCvs2etPx+FFsK5gr/Da0OQpSZrvuEoHASvUIznGr6h5XfhhWu8R2wg==
X-Received: by 2002:a05:600c:190b:b0:43d:fa5f:7d04 with SMTP id 5b1f17b1804b1-43ebf017220mr40329405e9.16.1743693108050;
        Thu, 03 Apr 2025 08:11:48 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ec3174cf0sm22156055e9.0.2025.04.03.08.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 08:11:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Make chip parameter to pwmchip_get_drvdata a const pointer
Date: Thu,  3 Apr 2025 17:11:32 +0200
Message-ID: <20250403151134.266388-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cNA+lbDCTn9KwfAUWg8VK4M//4tqdlt82Ex4ZpX72jU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn7qUmBf4/YANBawSue/rDSbwa5tDhdZL7FISLw GAEw48haraJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ+6lJgAKCRCPgPtYfRL+ TkDWB/9UZb6JhFSrRIu5QTdeg9+8UjlWJbzyWv6c8KqQMfKMQJd0wBDS1OCN592xmYUlW+Z6cxW QAeLVqL7ErejJpYUx4/l0Bdq6jn6dCaybYKi4d3Jqjwn2nADNwqpr9/PI6f1m9p+oSd15OD9IPe 6lhuyCKag59MXhg2jhlk12K9BZuWgJMLxuXJj0U2KSCuVjoICbsUD1LlzXeC++3hFugkxBQMZV0 k4zim5m+tkCJ25Y6KHtFD7cESLAOSQKlKut6w7kbDwJX7dZGiIK+RXF4K24vRknWatBkx937vWh vvfEDlo1WglOXTQdT46B/bHk9t73ZCSH0RjXfS+l+eG6Vx6i
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

dev_get_drvdata()'s parameter is a const pointer, so the chip passed to
pwmchip_get_drvdata can be const, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/pwm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9ece4e5d3815..bf0469b2201d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -369,7 +369,7 @@ static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
 	return chip->dev.parent;
 }
 
-static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
+static inline void *pwmchip_get_drvdata(const struct pwm_chip *chip)
 {
 	return dev_get_drvdata(&chip->dev);
 }

base-commit: 6df320abbb40654085d7258de33d78481e93ac8d
-- 
2.47.2


