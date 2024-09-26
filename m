Return-Path: <linux-pwm+bounces-3375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634B987062
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40ACB21217
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C471A4F16;
	Thu, 26 Sep 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQheAZ1y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557738FA3;
	Thu, 26 Sep 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343497; cv=none; b=gej5cWQsnKz9nWuquegr0lE98XmPGOj4U0aJriBtRVaAn0Rwz2HsXfp9qZ9Jvirc9yJ0kLvRSV6jeWlZZTntNcLmkmNOpeUXrmDKKI+3qX+U3UYevCF1y2AclYrCWZMpvN5L6A6X+LgdO2ui/dNDFQNIpr7mc8XlqdrYlEdwhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343497; c=relaxed/simple;
	bh=qScvP8P9xx7hLbHKx7dQASxlbWNGucAP1NZhNK5pLRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QZXnpuKwMeu1vSVJ307leSUcgw34GPV213scWjazbRGX+WG29w1WR1waXuKKoxt0cmOiFSoPuj1oEE7eu64o9ejuEvsuHl6k6H/tGG4q9UbLemHrpxd7fNmeDDEvmzByEaCEitCv4iYrjc07MRdSpKYZu1kHf+NLLVRWkdVhMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQheAZ1y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a90188ae58eso95839966b.1;
        Thu, 26 Sep 2024 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727343493; x=1727948293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6R+5KcNZ/aUYuiGzfFgNRbA94w9SXEb0wbMS+GUYlE=;
        b=YQheAZ1yhHdGyUgIqu18lsue98sPgn4xY+UwyjYnlWHTYcB7ED9GbfkCvOaFKWNu95
         DNRklhUCATs1vajmKJ5Kz7XeDtgf290A60fmiV/yMmcmaa/d3PCC2qQ+OUYgfY1qiZVF
         HnI+YGvowKmrtItmrOVYl1A6YNRmFzGL5HsANhRIKZxpnNeJxkMtplMk2QbAT0RKaqOQ
         Q5bWFSr1wJN4SGjNpbQsjFQhffVV2rKixuenugI4DLjdCli5aGyy8uXUTLUQ2EDt9Gnr
         TGQP43M3F6chSVcf9iEpXKkpOm2nu9dtSkTAqnwHKQmGqEwVXKmDlksQxS9GCSkZ6PuW
         xtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343493; x=1727948293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6R+5KcNZ/aUYuiGzfFgNRbA94w9SXEb0wbMS+GUYlE=;
        b=QZOci0eRtZmnnNJmaDuLE8cGk6Jy0lhpkXK0K6s+LAUWwNClpuwoeSR02u7wGEBubW
         2yEcTq4cXavINX3n8uA+lQhTMa3iEMgOZVKFpnMLIq3NlVFo8jCr9NF9sRhqM4d6RlrR
         fa5eUVVOF+jSKWB0peMqsyWy91ra+U9W+w88rwEwAfa0l40cnGMi9EeIMo4LsgTTlyR1
         ggH0pXlxsOYLSbibNB0WN6Wo9XpXyGJafmb8CgzYbFgdL7jGORyoJ0DT1Iknk7aO5gSx
         Q+R6ahoLhf5Jy7tIzC82JU/x43gR1eZvEEQSjtq5G97ZKGp4kNRTc+kG9FK9rudRevAk
         1zqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHx7Of+xB9lMDQm5eFbKvXd4UD2mqDY6OsVYSWxcIAzmXQuwG+eoFGcWnwFShq/acJCqbDp9QV7ohNMrY=@vger.kernel.org, AJvYcCWuh8yGcZPvn4GufCRBdDTgUmNz3mA6SfDq0oZbnOwZ40USdeDGZZSPS7qEsy5JaB6Y7TK4ohrlEclF@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRBdh9mlJw+3c79yGtM85L1gQ2ny89OytMjXGRzQ03MjvBCOd
	ep+/QLA+PKrKl0d32NRZ/dRdx+nviKFeRA/mQ41Id27fI+95GvPf
X-Google-Smtp-Source: AGHT+IGYb31pyij47ajHjWwCsepUA6sCOcNfwXWjrjCXyOLYK5HLzXYFDeIPuoP7S2kEJd00nkx5IQ==
X-Received: by 2002:a17:907:7ba3:b0:a8d:7b7d:8c39 with SMTP id a640c23a62f3a-a93a05e7985mr489893366b.43.1727343493128;
        Thu, 26 Sep 2024 02:38:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-4e5f-6907-08e4-04ed.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4e5f:6907:8e4:4ed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f33470sm325743566b.28.2024.09.26.02.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:38:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 26 Sep 2024 11:38:11 +0200
Subject: [PATCH] hwmon: (adt7475) Fix memory leak in
 adt7475_fan_pwm_config()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-hwmon_adt7475_memleak-v1-1-89b8ee07507a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIIr9WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMz3Yzy3Py8+MSUEnMTc9P43NTcnNTEbF1js9Q0k9SUlFSTJAsloN6
 CotS0zAqwudGxtbUA+DhK62cAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727343491; l=1669;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qScvP8P9xx7hLbHKx7dQASxlbWNGucAP1NZhNK5pLRQ=;
 b=YhaUGPQb20+sdm9JafMG+XuxzE4jkoBPBWOBbjNXeBjq4fp1qEazPQJntFlwgidVBUONQhVMJ
 qhGCSZtLLIdARlKcqQd7ok/LYh0Kp0aH1XdMd+BmGAu7eOCHQHtLoI+
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The device_for_each_child_node() loop requires calls to
fwnode_handle_put() upon early returns to decrement the refcount of
the child node and avoid leaking memory.

There are multiple early returns within that loop in
adt7475_fan_pwm_config(), but fwnode_handle_put() is never called.
Instead of adding the missing calls, the scoped version of the loop can
be used to simplify the code and avoid mistakes in the future if new
early returns are added.

This issue was recently introduced and it does not affect old kernels
that do not support the scoped variant.

Fixes: 777c97ff08d0 ("hwmon: (adt7475) Add support for configuring initial PWM state")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/adt7475.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index ca466d12475a..5f2541c11fe9 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1735,11 +1735,10 @@ static int adt7475_pwm_properties_parse_args(struct fwnode_handle *fwnode,
 static int adt7475_fan_pwm_config(struct i2c_client *client)
 {
 	struct adt7475_data *data = i2c_get_clientdata(client);
-	struct fwnode_handle *child;
 	struct adt7475_pwm_config cfg = {};
 	int ret;
 
-	device_for_each_child_node(&client->dev, child) {
+	device_for_each_child_node_scoped(&client->dev, child) {
 		if (!fwnode_property_present(child, "pwms"))
 			continue;
 

---
base-commit: 92fc9636d1471b7f68bfee70c776f7f77e747b97
change-id: 20240926-hwmon_adt7475_memleak-36ef4edde4b8

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


