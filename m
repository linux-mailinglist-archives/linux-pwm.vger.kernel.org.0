Return-Path: <linux-pwm+bounces-4607-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7AA0C2EE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 22:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A194169E40
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B51E04BE;
	Mon, 13 Jan 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GTkWD8uq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770761D1730
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802060; cv=none; b=Bk52D7olDJcoj0nKjDJtVSxh/fBhOcWhJh4zoZmjCXP812l0oWuY/9XhqR2mXA6cdCDDJz8JgdyiykATeoKeQqhs92fPABvEu2PwD6IG2KdJzf4drWPpcfbj9Iw+O+EPG76lLXkpEMYXNojNAQLAWq/B4HF5phvT/21FYkkVmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802060; c=relaxed/simple;
	bh=queoE3Dg5nPxxqFXS6WHbnUhCzibnN4tklRV8ZsWt+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQlkA2o3hEx95mfxKP/YMFg2NELnb2Y1OEW+7hsT3sy5Bt8VIAkd9nQgA/EWFt9/X4L6XlNlt556vNbwyvT+qjXJsDOIx6l8QNJgUBPPi3e4XJ0WJuojxdJv14kX50JUkum4psQFDLVIOmAkUdQM6Ak0pCLVwzDtpeZ6TqZ3Nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GTkWD8uq; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71fbb0d035dso2749484a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802055; x=1737406855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWygsU2wJJALZjruh3DSmbdGzB4EfqJmJ4z20++2StM=;
        b=GTkWD8uqDhHfcOVhLP6iAgfv8RhAe8viXGbwX9FURS3qD3RFkEvlv6naaJPtlX9a5A
         csPyPE0Dwr90nzrtI5aNPoascvCcofpeVh0gDIjoS3qqBTRZsuGJpSFI7IVrRBa2yxgu
         LPQuufTVDC1EdI9bySXDdiSMiXhmt84aU9mFEeTr5/qaAF2xy836qMnLpM/gP9xXEdwI
         xthHGK1vjRPoz4/Yrjw2GoM3MlV1YonkBJPZJ7M7/N0QV68JkEl96CY7S4TNXCfhOV04
         yeSjxtWP5nrnyNr85J31GTItXH8qW0D2xnQrZc63Mfc4ffagA2INQdQ5kMZ6bOfBXmNq
         jjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802055; x=1737406855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWygsU2wJJALZjruh3DSmbdGzB4EfqJmJ4z20++2StM=;
        b=EkmWlWeYADnKnwEb+rcetjVVbWJdYLVAIjM727+nkGdOm9p3TpyztB3u3RGMZs4vfP
         CPEq1TPBEJB0OA052o7iEy2LRkPO0SWqWLeBkOdWwixUB7ps/4myDibyiTCHzEIyVeo1
         hrRG4fHPcudA0PFTmao4YzYJNjd85SDsytr8KpxT7/3y8v02rMgCkDV6mrFoW15SRmLi
         3f9+3x7NW9r2ifPJ/rU3a5KVwWfMKIE++dGDkIIvQEUPMqtESChexAPsYRaZbD2PQ56x
         UnDyrKFfrkslHF9Z56G1Yoi9Cx8c0EgwhS0/vZ6d4/4yc80gwwlWDu0LFGnmi3StvhrK
         KcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWn+xbfhdFuqdrzhu+CPeO3MiX+o//9Y/inCV7g2Q3T+SYDuKxJn1SVTBUFnuEGrwybfn0RQQ+WrwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXRMdSsPagnggFUzPlVBRHEbNnmexUwMztJ80JyuqTdJYaaeI
	0FgKQOkMiEQEAiqAeC66fC8s3gRBjTeqdMrzX5VvaEzJvI4R0O/QNRYlnkvhjZ4=
X-Gm-Gg: ASbGncvPrV+RK6Xm+hA3dA5QThAWHMWea2iCc/5WzJsOkanfOH+4IJOLMqbheEWpy+g
	miF6pSADZ+k+KtTX4MzAC7Ni3DV8tvfF2DsbZ4AXqTAh4zPZpcX1OggX16cBKnRAoQMtYbPqz/v
	Ch0bcWJM5xwO+VBPoWwgFrG2jE6kefEl+mk92UBWzisi0lFJBsVm3eZt1M4Ub2twyD6VK/jErTr
	jQoXeOmqcy9VqS8SbDpj7ai7MQpPvRVxsGnTRzCZqNOfOcAWzRFPFIys7W4gDtgU1UaDxKIsIti
	Lg9ZbWZK3ePh
X-Google-Smtp-Source: AGHT+IHSJQYA1Ymw3grOJiz73CvxNw1BtGeRCl3eup9KoB6KlwUpCYI78fWonP1AnrjK8Nn2/2zrjQ==
X-Received: by 2002:a05:6830:4410:b0:71d:4698:7b24 with SMTP id 46e09a7af769-721e2e7073emr15016281a34.16.1736802055476;
        Mon, 13 Jan 2025 13:00:55 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:00:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:07 -0600
Subject: [PATCH v7 02/17] spi: offload: add support for hardware triggers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-2-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Updated for header file split.

v5 changes:
* Use struct kref instead of struct dev for trigger lifetime management.
* Don't use __free() for args.fwnode.
* Pass *trigger instead of *priv to all callbacks.
* Add new *spi_offload_trigger_get_priv() function.
* Use ops instead of priv for "provider is gone" flag.
* Combine devm_spi_offload_trigger_alloc() and
  devm_spi_offload_trigger_register() into one function.
* Add kernel-doc comments for public functions.

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
 drivers/spi/spi-offload.c            | 281 +++++++++++++++++++++++++++++++++++
 include/linux/spi/offload/consumer.h |  12 ++
 include/linux/spi/offload/provider.h |  28 ++++
 include/linux/spi/offload/types.h    |  37 +++++
 4 files changed, 358 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 3a40ef30debf09c6fd7b2c14526f3e5976e2b21f..43582e50e279c4b1b958765fec556aaa91180e55 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -19,7 +19,11 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/spi/offload/consumer.h>
 #include <linux/spi/offload/provider.h>
 #include <linux/spi/offload/types.h>
@@ -31,6 +35,23 @@ struct spi_controller_and_offload {
 	struct spi_offload *offload;
 };
 
+struct spi_offload_trigger {
+	struct list_head list;
+	struct kref ref;
+	struct fwnode_handle *fwnode;
+	/* synchronizes calling ops and driver registration */
+	struct mutex lock;
+	/*
+	 * If the provider goes away while the consumer still has a reference,
+	 * ops and priv will be set to NULL and all calls will fail with -ENODEV.
+	 */
+	const struct spi_offload_trigger_ops *ops;
+	void *priv;
+};
+
+static LIST_HEAD(spi_offload_triggers);
+static DEFINE_MUTEX(spi_offload_triggers_lock);
+
 /**
  * devm_spi_offload_alloc() - Allocate offload instance
  * @dev: Device for devm purposes and assigned to &struct spi_offload.provider_dev
@@ -112,3 +133,263 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
 	return resource->offload;
 }
 EXPORT_SYMBOL_GPL(devm_spi_offload_get);
+
+static void spi_offload_trigger_free(struct kref *ref)
+{
+	struct spi_offload_trigger *trigger =
+		container_of(ref, struct spi_offload_trigger, ref);
+
+	mutex_destroy(&trigger->lock);
+	fwnode_handle_put(trigger->fwnode);
+	kfree(trigger);
+}
+
+static void spi_offload_trigger_put(void *data)
+{
+	struct spi_offload_trigger *trigger = data;
+
+	scoped_guard(mutex, &trigger->lock)
+		if (trigger->ops && trigger->ops->release)
+			trigger->ops->release(trigger);
+
+	kref_put(&trigger->ref, spi_offload_trigger_free);
+}
+
+static struct spi_offload_trigger
+*spi_offload_trigger_get(enum spi_offload_trigger_type type,
+			 struct fwnode_reference_args *args)
+{
+	struct spi_offload_trigger *trigger;
+	bool match = false;
+	int ret;
+
+	guard(mutex)(&spi_offload_triggers_lock);
+
+	list_for_each_entry(trigger, &spi_offload_triggers, list) {
+		if (trigger->fwnode != args->fwnode)
+			continue;
+
+		match = trigger->ops->match(trigger, type, args->args, args->nargs);
+		if (match)
+			break;
+	}
+
+	if (!match)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->ops)
+		return ERR_PTR(-ENODEV);
+
+	if (trigger->ops->request) {
+		ret = trigger->ops->request(trigger, type, args->args, args->nargs);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	kref_get(&trigger->ref);
+
+	return trigger;
+}
+
+/**
+ * devm_spi_offload_trigger_get() - Get an offload trigger instance
+ * @dev: Device for devm purposes.
+ * @offload: Offload instance connected to a trigger.
+ * @type: Trigger type to get.
+ *
+ * Return: Offload trigger instance or error on failure.
+ */
+struct spi_offload_trigger
+*devm_spi_offload_trigger_get(struct device *dev,
+			      struct spi_offload *offload,
+			      enum spi_offload_trigger_type type)
+{
+	struct spi_offload_trigger *trigger;
+	struct fwnode_reference_args args;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(offload->provider_dev),
+						 "trigger-sources",
+						 "#trigger-source-cells", 0, 0,
+						 &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	trigger = spi_offload_trigger_get(type, &args);
+	fwnode_handle_put(args.fwnode);
+	if (IS_ERR(trigger))
+		return trigger;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_put, trigger);
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
+	if (!trigger->ops)
+		return -ENODEV;
+
+	if (!trigger->ops->validate)
+		return -EOPNOTSUPP;
+
+	return trigger->ops->validate(trigger, config);
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_validate);
+
+/**
+ * spi_offload_trigger_enable - enables trigger for offload
+ * @offload: Offload instance
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
+	if (!trigger->ops)
+		return -ENODEV;
+
+	if (offload->ops && offload->ops->trigger_enable) {
+		ret = offload->ops->trigger_enable(offload);
+		if (ret)
+			return ret;
+	}
+
+	if (trigger->ops->enable) {
+		ret = trigger->ops->enable(trigger, config);
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
+ * @trigger: Offload trigger instance
+ *
+ * Disables the hardware trigger for the offload instance with the specified ID
+ * and releases the bus for use by other clients.
+ *
+ * Context: can sleep
+ */
+void spi_offload_trigger_disable(struct spi_offload *offload,
+				 struct spi_offload_trigger *trigger)
+{
+	if (offload->ops && offload->ops->trigger_disable)
+		offload->ops->trigger_disable(offload);
+
+	guard(mutex)(&trigger->lock);
+
+	if (!trigger->ops)
+		return;
+
+	if (trigger->ops->disable)
+		trigger->ops->disable(trigger);
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
+
+/* Triggers providers */
+
+static void spi_offload_trigger_unregister(void *data)
+{
+	struct spi_offload_trigger *trigger = data;
+
+	scoped_guard(mutex, &spi_offload_triggers_lock)
+		list_del(&trigger->list);
+
+	scoped_guard(mutex, &trigger->lock) {
+		trigger->priv = NULL;
+		trigger->ops = NULL;
+	}
+
+	kref_put(&trigger->ref, spi_offload_trigger_free);
+}
+
+/**
+ * devm_spi_offload_trigger_register() - Allocate and register an offload trigger
+ * @dev: Device for devm purposes.
+ * @info: Provider-specific trigger info.
+ *
+ * Return: 0 on success, else a negative error code.
+ */
+int devm_spi_offload_trigger_register(struct device *dev,
+				      struct spi_offload_trigger_info *info)
+{
+	struct spi_offload_trigger *trigger;
+
+	if (!info->fwnode || !info->ops)
+		return -EINVAL;
+
+	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
+	if (!trigger)
+		return -ENOMEM;
+
+	kref_init(&trigger->ref);
+	mutex_init(&trigger->lock);
+	trigger->fwnode = fwnode_handle_get(info->fwnode);
+	trigger->ops = info->ops;
+	trigger->priv = info->priv;
+
+	scoped_guard(mutex, &spi_offload_triggers_lock)
+		list_add_tail(&trigger->list, &spi_offload_triggers);
+
+	return devm_add_action_or_reset(dev, spi_offload_trigger_unregister, trigger);
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_register);
+
+/**
+ * spi_offload_trigger_get_priv() - Get the private data for the trigger
+ *
+ * @trigger: Offload trigger instance.
+ *
+ * Return: Private data for the trigger.
+ */
+void *spi_offload_trigger_get_priv(struct spi_offload_trigger *trigger)
+{
+	return trigger->priv;
+}
+EXPORT_SYMBOL_GPL(spi_offload_trigger_get_priv);
diff --git a/include/linux/spi/offload/consumer.h b/include/linux/spi/offload/consumer.h
index 05543dbedf3086fb4befcd149cff3c8c70a88825..5a0ec5303d600728959594bcdbd0cb2baeba7c77 100644
--- a/include/linux/spi/offload/consumer.h
+++ b/include/linux/spi/offload/consumer.h
@@ -19,4 +19,16 @@ struct spi_device;
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
 #endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
diff --git a/include/linux/spi/offload/provider.h b/include/linux/spi/offload/provider.h
index 278c4edfcdb7b1f43870ca99d2ba252bf2820576..76c7cf65109241f39c6ab72f0e15454a874b6c24 100644
--- a/include/linux/spi/offload/provider.h
+++ b/include/linux/spi/offload/provider.h
@@ -8,12 +8,40 @@
 #define __LINUX_SPI_OFFLOAD_PROVIDER_H
 
 #include <linux/module.h>
+#include <linux/spi/offload/types.h>
 #include <linux/types.h>
 
 MODULE_IMPORT_NS("SPI_OFFLOAD");
 
 struct device;
+struct spi_offload_trigger;
 
 struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
 
+struct spi_offload_trigger_ops {
+	bool (*match)(struct spi_offload_trigger *trigger,
+		      enum spi_offload_trigger_type type, u64 *args, u32 nargs);
+	int (*request)(struct spi_offload_trigger *trigger,
+		       enum spi_offload_trigger_type type, u64 *args, u32 nargs);
+	void (*release)(struct spi_offload_trigger *trigger);
+	int (*validate)(struct spi_offload_trigger *trigger,
+			struct spi_offload_trigger_config *config);
+	int (*enable)(struct spi_offload_trigger *trigger,
+		      struct spi_offload_trigger_config *config);
+	void (*disable)(struct spi_offload_trigger *trigger);
+};
+
+struct spi_offload_trigger_info {
+	/** @fwnode: Provider fwnode, used to match to consumer. */
+	struct fwnode_handle *fwnode;
+	/** @ops: Provider-specific callbacks. */
+	const struct spi_offload_trigger_ops *ops;
+	/** Provider-specific state to be used in callbacks. */
+	void *priv;
+};
+
+int devm_spi_offload_trigger_register(struct device *dev,
+				      struct spi_offload_trigger_info *info);
+void *spi_offload_trigger_get_priv(struct spi_offload_trigger *trigger);
+
 #endif /* __LINUX_SPI_OFFLOAD_PROVIDER_H */
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index a74f8d84541b10062353e81a638f05628b696394..7476f2073b02ee0f9edd3ae75e587b075746fa92 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -38,6 +38,43 @@ struct spi_offload {
 	struct device *provider_dev;
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
 
 #endif /* __LINUX_SPI_OFFLOAD_TYPES_H */

-- 
2.43.0


