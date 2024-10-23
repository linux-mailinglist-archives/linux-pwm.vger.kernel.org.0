Return-Path: <linux-pwm+bounces-3779-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6D9AD5F6
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387311C21352
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD61E8835;
	Wed, 23 Oct 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UxcUNV36"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1E1FAC3F
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717167; cv=none; b=gRDUFfFDLBIZcnPatyuckV5TxX6WmMXA+LGcrtmKyhuTWvWk/faTWmZRRzEFU5d9TCQH723CPqAYws/yuMI/W3FvVpVgppHortf+FQYtIrYEaHvY6X55Kle6uAN6FSq67bnsZ7Jrz8M8aguCy1sl7H5NgZ8R4+DpVqA/JibP8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717167; c=relaxed/simple;
	bh=p6qF5mGDsz6vMJiS+LL9qxqMe04AH3Kc8N5y/6sHtUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdjU76vFslFaiA9clA5HQQOs8IaOSWwI5/Yt5ou0CheB9F97eaaxXSCGCYmAXNe0nYy6btsKNU5UDPhdqbPNUntOx7BcXpNt/86lkQjreYPt6Gv9WPToWfuTuwNltURfCECwejlPSgIKuzilMDSHSwYBavI/teOlrc1hWvwmfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UxcUNV36; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5eb5f07410aso105504eaf.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717164; x=1730321964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cyi99RQueV0J22D6L8nca1luUo2oo0lC/4Jl1o/vrjM=;
        b=UxcUNV36pyzy9hq5Y3lbs1bPQxYJUGGnxJ3+7Azo6dR1zGb4i0eyxNgOmzGnoyl8MN
         NWiWqCN4wPJwFmAdvL4A3tB+U3PaC0ZIcfM7cEXeeMfdFOJzUN6eh4gP0Q243yS88/V6
         KGQ2eHYjzgA9bPSZyV0yB2IVoehk6YRmFshQ5lwCRgLdtQzz/a8ri0gLXh6mr4LsLggw
         hqmWcOkO80q82zo+OSNeXuC6JsIKYWbHuWapaBntCI7ZMZgIEUcpyiEdn589yysRqjBW
         7zBzCPnLjryjXdWq2lAfrrA4oVt6AePnu3iMtzdSTs3J6ot4OT98JKAMVJJKqJrQaiAT
         THyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717164; x=1730321964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyi99RQueV0J22D6L8nca1luUo2oo0lC/4Jl1o/vrjM=;
        b=CHOWfI+TAbQF7/RHUHgXgPTZDX2VMh7Xr07ZMysj0LUkNgkMj0AdGLBPU2/Sdh0ppz
         lGBFzhkPS/VIT+LsSKyImOusOA3MeEvcrFTfJYZswCpVD3DlCgxZTA7iP99NJl26CUHS
         sRP+ko4h1lvdhVqdmdilvOzxrI8PWfJgTGQLRuA70i2YksqnMEboNtnrpiGv1tSxdT1B
         HWu37PtOvYdaywy0uA5xVBL/BTLoTvJc/8VX6zOkB1pXEHfVAarsKqAdQkwluPv771Aa
         SwNJUCGca7LU2vKFq4g0GoCga9iqyIHVVSyjlE/ywtzU7oISSBNgslfGHgOqFwNs2GLP
         0BNw==
X-Forwarded-Encrypted: i=1; AJvYcCUL0cTVEWjChNHMWbCfudIBwja07/3++LZRHKj04RtBnlJ4F1jW26qIYTOnqcLUHpI3vHLudZo7V3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxS6XZ2gRXdKWf55MHDNNOuCQOm6ms/qV6bvLP4L3ojqku7WP
	9bTf7XbWtHDtbVrrUViIMRnRc4P2BZ/rjdLGeh3QFeVGEcpz49aEoytb2XmoGJw=
X-Google-Smtp-Source: AGHT+IH/EsQ0tknTvoN94FNxLmCCF0hi6zC7K1hBIZR7SFC/n9cF9xbVrfJFGJqW7iPxRqs2uhP34g==
X-Received: by 2002:a05:6820:808:b0:5eb:b282:5351 with SMTP id 006d021491bc7-5ebee4a0773mr3208875eaf.2.1729717164425;
        Wed, 23 Oct 2024 13:59:24 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:10 -0500
Subject: [PATCH RFC v4 03/15] spi: offload: add support for hardware
 triggers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Extend SPI offloading to support hardware triggers.

This allows an arbitrary hardware trigger to be used to start a SPI
transfer that was previously set up with spi_optimize_message().

A new struct spi_offload_trigger is introduced that can be used to
configure any type of trigger. It has a type discriminator and a union
to allow it to be extended in the future. Two trigger types are defined
to start with. One is a trigger that indicates that the SPI peripheral
is ready to read or write data. The other is a periodic trigger to
repeat a SPI message at a fixed rate.

There is also a spi_offload_hw_trigger_validate() function that works
similar to clk_round_rate(). It basically asks the question of if we
enabled the hardware trigger what would the actual parameters be. This
can be used to test if the requested trigger type is actually supported
by the hardware and for periodic triggers, it can be used to find the
actual rate that the hardware is capable of.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

In previous versions, we locked the SPI bus when the hardware trigger
was enabled, but we found this to be too restrictive. In one use case,
to avoid a race condition, we need to enable the SPI offload via a
hardware trigger, then write a SPI message to the peripheral to place
it into a mode that will generate the trigger. If we did it the other
way around, we could miss the first trigger.

Another likely use case will be enabling two offloads/triggers at one
time on the same device, e.g. a read trigger and a write trigger. So
the exclusive bus lock for a single trigger would be too restrictive in
this case too.

So for now, I'm going with Nuno's suggestion to leave any locking up to
the individual controller driver. If we do find we need something more
generic in the future, we could add a new spi_bus_lock_exclusive() API
that causes spi_bus_lock() to fail instead of waiting and add "locked"
versions of trigger enable functions. This would allow a peripheral to
claim exclusive use of the bus indefinitely while still being able to
do any SPI messaging that it needs.

v4 changes:
* Added new struct spi_offload_trigger that is a generic struct for any
  hardware trigger rather than returning a struct clk.
* Added new spi_offload_hw_trigger_validate() function.
* Dropped extra locking since it was too restrictive.

v3 changes:
* renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
* added spi_offload_hw_trigger_get_clk() function
* fixed missing EXPORT_SYMBOL_GPL

v2 changes:
* This is split out from "spi: add core support for controllers with
  offload capabilities".
* Added locking for offload trigger to claim exclusive use of the SPI
  bus.
---
 drivers/spi/spi-offload.c       | 266 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-offload.h |  78 ++++++++++++
 2 files changed, 344 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index c344cbf50bdb..2a1f9587f27a 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -9,12 +9,26 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
+struct spi_offload_trigger {
+	struct list_head list;
+	struct device dev;
+	/* synchronizes calling ops and driver registration */
+	struct mutex lock;
+	const struct spi_offload_trigger_ops *ops;
+	void *priv;
+};
+
+static LIST_HEAD(spi_offload_triggers);
+static DEFINE_MUTEX(spi_offload_triggers_lock);
+
 /**
  * devm_spi_offload_alloc() - Allocate offload instances
  * @dev: Device for devm purposes
@@ -102,3 +116,255 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 	return offload;
 }
 EXPORT_SYMBOL_GPL(devm_spi_offload_get);
+
+static void spi_offload_trigger_release(void *data)
+{
+	struct spi_offload_trigger *trigger = data;
+
+	guard(mutex)(&trigger->lock);
+	if (trigger->priv && trigger->ops->release)
+		trigger->ops->release(trigger->priv);
+
+	put_device(&trigger->dev);
+}
+
+struct spi_offload_trigger
+*devm_spi_offload_trigger_get(struct device *dev,
+			      struct spi_offload *offload,
+			      enum spi_offload_trigger_type type)
+{
+	struct spi_offload_trigger *trigger;
+	struct fwnode_reference_args args;
+	bool match = false;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(offload->provider_dev),
+						 "trigger-sources",
+						 "#trigger-source-cells", 0, 0,
+						 &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	struct fwnode_handle *trigger_fwnode __free(fwnode_handle) = args.fwnode;
+
+	guard(mutex)(&spi_offload_triggers_lock);
+
+	list_for_each_entry(trigger, &spi_offload_triggers, list) {
+		if (trigger->dev.fwnode != args.fwnode)
+			continue;
+
+		match = trigger->ops->match(trigger->priv, type, args.args, args.nargs);
+		if (match)
+			break;
+	}
+
+	if (!match)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->priv)
+		return ERR_PTR(-ENODEV);
+
+	if (trigger->ops->request) {
+		ret = trigger->ops->request(trigger->priv, type, args.args, args.nargs);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	get_device(&trigger->dev);
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_release, trigger);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return trigger;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_get);
+
+/**
+ * spi_offload_trigger_validate - Validate the requested trigger
+ * @trigger: Offload trigger instance
+ * @config: Trigger config to validate
+ *
+ * On success, @config may be modifed to reflect what the hardware can do.
+ * For example, the frequency of a periodic trigger may be adjusted to the
+ * nearest supported value.
+ *
+ * Callers will likely need to do additional validation of the modified trigger
+ * parameters.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int spi_offload_trigger_validate(struct spi_offload_trigger *trigger,
+				 struct spi_offload_trigger_config *config)
+{
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->priv)
+		return -ENODEV;
+
+	if (!trigger->ops->validate)
+		return -EOPNOTSUPP;
+
+	return trigger->ops->validate(trigger->priv, config);
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_validate);
+
+/**
+ * spi_offload_trigger_enable - enables trigger for offload
+ * @trigger: Offload trigger instance
+ * @config: Trigger config to validate
+ *
+ * There must be a prepared offload instance with the specified ID (i.e.
+ * spi_optimize_message() was called with the same offload assigned to the
+ * message). This will also reserve the bus for exclusive use by the offload
+ * instance until the trigger is disabled. Any other attempts to send a
+ * transfer or lock the bus will fail with -EBUSY during this time.
+ *
+ * Calls must be balanced with spi_offload_trigger_disable().
+ *
+ * Context: can sleep
+ * Return: 0 on success, else a negative error code.
+ */
+int spi_offload_trigger_enable(struct spi_offload *offload,
+			       struct spi_offload_trigger *trigger,
+			       struct spi_offload_trigger_config *config)
+{
+	int ret;
+
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->priv)
+		return -ENODEV;
+
+	if (offload->ops->trigger_enable) {
+		ret = offload->ops->trigger_enable(offload);
+		if (ret)
+			return ret;
+	}
+
+	if (trigger->ops->enable) {
+		ret = trigger->ops->enable(trigger->priv, config);
+		if (ret) {
+			if (offload->ops->trigger_disable)
+				offload->ops->trigger_disable(offload);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_enable);
+
+/**
+ * spi_offload_trigger_disable - disables hardware trigger for offload
+ * @offload: Offload instance
+ *
+ * Disables the hardware trigger for the offload instance with the specified ID
+ * and releases the bus for use by other clients.
+ *
+ * Context: can sleep
+ */
+void spi_offload_trigger_disable(struct spi_offload *offload,
+				 struct spi_offload_trigger *trigger)
+{
+	if (offload->ops->trigger_disable)
+		offload->ops->trigger_disable(offload);
+
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->priv)
+		return;
+
+	if (trigger->ops->disable)
+		trigger->ops->disable(trigger->priv);
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
+
+/* Triggers providers */
+
+static void spi_offload_trigger_dev_release(struct device *dev)
+{
+	struct spi_offload_trigger *trigger =
+		container_of(dev, struct spi_offload_trigger, dev);
+
+	mutex_destroy(&trigger->lock);
+	of_node_put(trigger->dev.of_node);
+	kfree(trigger);
+}
+
+static void spi_offload_trigger_put(void *data)
+{
+	struct spi_offload_trigger *trigger = data;
+
+	put_device(&trigger->dev);
+}
+
+struct spi_offload_trigger
+*devm_spi_offload_trigger_alloc(struct device *dev,
+				struct spi_offload_trigger_info *info)
+{
+	struct spi_offload_trigger *trigger;
+	int ret;
+
+	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
+	if (!trigger)
+		return ERR_PTR(-ENOMEM);
+
+	device_initialize(&trigger->dev);
+	trigger->dev.parent = info->parent;
+	trigger->dev.fwnode = info->fwnode;
+	trigger->dev.of_node = of_node_get(to_of_node(trigger->dev.fwnode));
+	trigger->dev.of_node_reused = true;
+	trigger->dev.release = spi_offload_trigger_dev_release;
+
+	mutex_init(&trigger->lock);
+	trigger->ops = info->ops;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_put, trigger);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = dev_set_name(&trigger->dev, "%s-%d", info->name, info->id);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return trigger;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_alloc);
+
+static void spi_offload_trigger_unregister(void *data)
+{
+	struct spi_offload_trigger *trigger = data;
+
+	scoped_guard(mutex, &spi_offload_triggers_lock)
+		list_del(&trigger->list);
+
+	guard(mutex)(&trigger->lock);
+	trigger->priv = NULL;
+	device_del(&trigger->dev);
+}
+
+int devm_spi_offload_trigger_register(struct device *dev,
+				      struct spi_offload_trigger *trigger,
+				      void *priv)
+{
+	int ret;
+
+	ret = device_add(&trigger->dev);
+	if (ret)
+		return ret;
+
+	trigger->priv = priv;
+
+	guard(mutex)(&spi_offload_triggers_lock);
+	list_add_tail(&trigger->list, &spi_offload_triggers);
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_unregister, trigger);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_register);
diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
index 92a557533b83..561cc1fb6f35 100644
--- a/include/linux/spi/spi-offload.h
+++ b/include/linux/spi/spi-offload.h
@@ -22,6 +22,7 @@
 MODULE_IMPORT_NS(SPI_OFFLOAD);
 
 struct device;
+struct fwnode_handle;
 struct spi_device;
 
 /* Offload can be triggered by external hardware event. */
@@ -53,6 +54,43 @@ struct spi_offload {
 	struct spi_device *spi;
 	/** @priv: provider driver private data */
 	void *priv;
+	/** @ops: callbacks for offload support */
+	const struct spi_offload_ops *ops;
+};
+
+enum spi_offload_trigger_type {
+	/* Indication from SPI peripheral that data is read to read. */
+	SPI_OFFLOAD_TRIGGER_DATA_READY,
+	/* Trigger comes from a periodic source such as a clock. */
+	SPI_OFFLOAD_TRIGGER_PERIODIC,
+};
+
+struct spi_offload_trigger_periodic {
+	u64 frequency_hz;
+};
+
+struct spi_offload_trigger_config {
+	/** @type: type discriminator for union */
+	enum spi_offload_trigger_type type;
+	union {
+		struct spi_offload_trigger_periodic periodic;
+	};
+};
+
+/**
+ * struct spi_offload_ops - callbacks implemented by offload providers
+ */
+struct spi_offload_ops {
+	/**
+	 * @trigger_enable: Optional callback to enable the trigger for the
+	 * given offload instance.
+	 */
+	int (*trigger_enable)(struct spi_offload *offload);
+	/**
+	 * @trigger_disable: Optional callback to disable the trigger for the
+	 * given offload instance.
+	 */
+	void (*trigger_disable)(struct spi_offload *offload);
 };
 
 struct spi_offload *devm_spi_offload_alloc(struct device *dev,
@@ -61,4 +99,44 @@ struct spi_offload *devm_spi_offload_alloc(struct device *dev,
 struct spi_offload *devm_spi_offload_get(struct device *dev, struct spi_device *spi,
 					 const struct spi_offload_config *config);
 
+struct spi_offload_trigger
+*devm_spi_offload_trigger_get(struct device *dev,
+			      struct spi_offload *offload,
+			      enum spi_offload_trigger_type type);
+int spi_offload_trigger_validate(struct spi_offload_trigger *trigger,
+				 struct spi_offload_trigger_config *config);
+int spi_offload_trigger_enable(struct spi_offload *offload,
+			       struct spi_offload_trigger *trigger,
+			       struct spi_offload_trigger_config *config);
+void spi_offload_trigger_disable(struct spi_offload *offload,
+				 struct spi_offload_trigger *trigger);
+
+/* Trigger providers */
+
+struct spi_offload_trigger;
+
+struct spi_offload_trigger_ops {
+	bool (*match)(void *priv, enum spi_offload_trigger_type type, u64 *args, u32 nargs);
+	int (*request)(void *priv, enum spi_offload_trigger_type type, u64 *args, u32 nargs);
+	void (*release)(void *priv);
+	int (*validate)(void *priv, struct spi_offload_trigger_config *config);
+	int (*enable)(void *priv, struct spi_offload_trigger_config *config);
+	void (*disable)(void *priv);
+};
+
+struct spi_offload_trigger_info {
+	const char *name;
+	int id;
+	struct device *parent;
+	struct fwnode_handle *fwnode;
+	const struct spi_offload_trigger_ops *ops;
+};
+
+struct spi_offload_trigger
+*devm_spi_offload_trigger_alloc(struct device *dev,
+				struct spi_offload_trigger_info *info);
+int devm_spi_offload_trigger_register(struct device *dev,
+				      struct spi_offload_trigger *trigger,
+				      void *priv);
+
 #endif /* __LINUX_SPI_OFFLOAD_H */

-- 
2.43.0


