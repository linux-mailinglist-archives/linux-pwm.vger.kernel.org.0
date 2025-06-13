Return-Path: <linux-pwm+bounces-6337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD96DAD88AF
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6323C17E997
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82D2C1592;
	Fri, 13 Jun 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVVV2n1O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5C29B78C;
	Fri, 13 Jun 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808979; cv=none; b=kzS/HbZGc4GpxIJUbpl9OG02ZAVj9/oWwZy/PmlzkRT0fBZl0oCkL8FxTmMR2pV3PWdMSRZVt3AmENyAxWJwj5X5P1U4p18Z3RCFbA+L+WCEl6IGDtr2NSSj4LL6yCuhBsGnM0bIW84kjg+3DIjf1prXrJHyxbk4WvpvobuJ8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808979; c=relaxed/simple;
	bh=1He0Fo9SkN9xUrKQXHkWW4Ed7cJbqP+af9I+R0FVlak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrO3pKueX9OwGPsU15+7yzk+3kgHr/amLS6wFEEbStpnvsuFeHOadEhwrJeqkZKsEQEWZJgL8iXISK8YwC2dkm4IZEjSEPBjgHwsRaOJR0HBhPAchR6BGM9mg21tHqg3n5XcxwQMzrIQlFdpYV/d4+eRoIBiXRFtFTg4W1Tdke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVVV2n1O; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so1581795a12.0;
        Fri, 13 Jun 2025 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749808977; x=1750413777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4CEJv3p+Vm6KRlJSHF8Wp9jYCnWqhDCGE2YwWaeevg=;
        b=ZVVV2n1ODqOJyhlP4Nj/Tc+n7kfGjBonrXmfl9AgnoWqkhjT/MeyMUeM1VcZvHu9Kg
         Z5zY+EY5Lefaqne4rF7V2Dn/UR0PaULY9EX+lQ+NfzSgwV6DdZuRBByiH1id34G3bExk
         i3dRIjCQwtwdOpezNX6Wy9NwRCLqMlc1D0m0sR1naVUFUbImeWHs+nsDinhrnj8gFevD
         GkfqDcVLNqymWxnaVxSPDIhua+b7NQdxucj27meXu/DAqa6AA2ujuFKrzB4K9xD3rHCi
         HrT+5vdJksuQsktFsnobf4uKNt0G29E2PK66kfaOMr+D/E/AjD0oFVPz97FjhdBKQfZS
         wQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749808977; x=1750413777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4CEJv3p+Vm6KRlJSHF8Wp9jYCnWqhDCGE2YwWaeevg=;
        b=SXJ26BW3aPNsfIsinlWHW/FlDbJrGvPtepkc7giSMSHQ4TAr0p8or5imElckVdsLGd
         6RonjXm318A0gnVmmYMI81jRh3aHXIOwwZolCcuAY/Emf+QjMgiq8FvBe8wWxWVIACrC
         2iXMthBa4BdKgjJSVdEDelzRB+rCQiIccA/VAI2azomVIw6JBfPASPkXBUi8W7xfmdId
         /Ltb+sRf5zhKboWBskofAPtm/xRIx5s0c6U8dbK4N5F3XKY8cL3QdRWlVr+G/UtqZF3p
         scBNiCB1QwS4SKL1rYEtBaUJvZzpUaSPd2Zdhq3YkjriAP5VHRq0kbZZCi5/r5pQb0cM
         ly8g==
X-Forwarded-Encrypted: i=1; AJvYcCUncoVHui+KvnG0FUkZ1E92QZ54KPeLaJ/QoNECBSG6AsrmFJfxIgr4HcSfQsIpWuQpW+q2G8y3sq6xY46G@vger.kernel.org, AJvYcCVm8k6hehX7J6t/pft80B+2uunEs/ECP6SU+LusW/cax9xEIZhQTbJ0XMvDzkdEhnkN7tEtCYbt+OB8@vger.kernel.org, AJvYcCWhvBb2rTuiz7znACcZvkuq0w3bE7+FNQps/AgSGT3WsgpVvdMmmNYIR9R/eXQj5d62Zuq3ekZC+yH1@vger.kernel.org, AJvYcCX3fVb1awHOO0YyxyWfID5tRVAetacbbMicHEvPzHmsb4448Nm9XuJT9+sIsyJGQu818s3mLhQbPsRu@vger.kernel.org, AJvYcCXJwee0aDvNI/7xGPJmICE7YmawEe+X/GCqQpLw8VrcOOYv8xUjKc+yBNjAIa9f+Z7BkxQxm1aVfArG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0x4q5dyYM8pU83ju/MIROS+qNOYnoGUOlVwCpzdjo+Urg2Fx
	KsXe7+KSephRKyIoMC7wtzF6zn3pylMsZMdVv7yNNW59PbuJCslk4R77
X-Gm-Gg: ASbGnct8Cqe68dibHEmP5hdXWC+nrjTecF9NQUmLG/YPup8QFLT/DUsxCEnztZQHtqH
	9N/YU5LVbqDJw5UxedigLy2j6puCRmS8f5Di7BMukqebHGr0tuA/nmrAKk42nvsJ5pfW3Ri+mMN
	7VlZ0ngi1a4MqbI30L+d/2x+EJL5DmCQUPf9gIsZ+8kknZ6re7SrfxoRDTBK9dou5HdS5MrZKp8
	HQFVA9OzclwkG6XaEb3HZLtz/EYZ/73ZGGGnHu9Vi4bJljmWBMSyrSTCUbyMB/I/yylXpLLUDEc
	/PYGVob7Rvm6vjmKoHBF0w/T8euzevNcjXU5KWQR4by1kb2NwII+f6UToqGhEA9Ik9QTTfrt4VC
	WXcdrHA==
X-Google-Smtp-Source: AGHT+IGJo4W5iYXGs2QfKCKVDEJUDaqqQ2ynkAzqBUZEjFuAAF34IIwPQJbwD717UGFYpSeooR1i1Q==
X-Received: by 2002:a05:6a20:2445:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-21facbca8dbmr3732040637.14.1749808977229;
        Fri, 13 Jun 2025 03:02:57 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c6asm1098952a12.42.2025.06.13.03.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:02:56 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:02:44 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Message-ID: <gvigk6helnl3yeouy636dgvay7tqux7lnxns3256fivzz4l3er@7ts7fz7vitff>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
 <afc85a4b-1535-406d-ad14-143049267b98@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc85a4b-1535-406d-ad14-143049267b98@baylibre.com>

Hi David,
On Thu, Jun 12, 2025 at 02:38:45PM -0500, David Lechner wrote:
> On 6/10/25 2:34 AM, Jorge Marques wrote:
> > The AD4052 family supports autonomous monitoring readings for threshold
> > crossings. Add support for catching the GPIO interrupt and expose as an IIO
> > event. The device allows to set either, rising and falling directions. Only
> > either threshold crossing is implemented.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> 
> ...
> 
> > +
> > +static ssize_t ad4052_events_frequency_store(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     const char *buf,
> > +					     size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> > +	}
> 
> I'm wondering if we should instead have some kind of iio_device_claim_monitor_mode()
> so that we don't have to implement this manually everywhere. If monitor mode was
> claimed, then iio_device_claim_direct() and iio_device_claim_buffer_mode() would
> both return -EBUSY. If buffer mode was claimed, iio_device_claim_monitor_mode()
> would fail. If direct mode was claimed, iio_device_claim_monitor_mode() would wait.
> 
I don't think this would scale with other vendors and devices, it is a
limitation of ADI:ADC:SPI requiring to enter configuration mode to read
registers. A deep dive into the other drivers that use IIO Events is
needed.
> > +
> > +	ret = __sysfs_match_string(AD4052_FS(st->chip->grade),
> > +				   AD4052_FS_LEN(st->chip->grade), buf);
> > +	if (ret < 0)
> > +		goto out_release;
> > +
> > +	st->events_frequency = ret;
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret ? ret : len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(sampling_frequency, 0644,
> > +		       ad4052_events_frequency_show,
> > +		       ad4052_events_frequency_store, 0);
> > +
> > +static ssize_t sampling_frequency_available_show(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 char *buf)
> > +{
> > +	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
> > +	int ret = 0;
> > +
> > +	for (u8 i = AD4052_FS_OFFSET(st->chip->grade);
> > +	     i < AD4052_FS_LEN(st->chip->grade); i++)
> > +		ret += sysfs_emit_at(buf, ret, "%s ", ad4052_conversion_freqs[i]);
> > +
> > +	ret += sysfs_emit_at(buf, ret, "\n");
> > +	return ret;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > +
> > +static struct attribute *ad4052_event_attributes[] = {
> > +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group ad4052_event_attribute_group = {
> > +	.attrs = ad4052_event_attributes,
> > +};
> > +
> >  static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
> >  				   struct iio_chan_spec const *chan)
> >  {
> > @@ -602,6 +699,19 @@ static int ad4052_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
> >  				  val);
> >  }
> >  
> > +static irqreturn_t ad4052_irq_handler_thresh(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +
> 
> Can we not read the status register here to find out what the exact
> event was? I guess that would require taking it out of monitor mode.
> 
It requires entering configuration mode and results in a monitoring
downtime. Earlier versions of this driver would do that, but the
conclusion was that it was better to have the user disabling events and
reading registers, so he is explicitly aware of the monitoring downtime.
> > +	iio_push_event(indio_dev,
> > +		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> > +					    IIO_EV_TYPE_THRESH,
> > +					    IIO_EV_DIR_EITHER),
> > +		       iio_get_time_ns(indio_dev));
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
> >  {
> >  	struct ad4052_state *st = private;
> > @@ -616,6 +726,18 @@ static int ad4052_request_irq(struct iio_dev *indio_dev)
> >  	struct device *dev = &st->spi->dev;
> >  	int ret;
> >  
> > +	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp0");
> > +	if (ret > 0) {
> > +		ret = devm_request_threaded_irq(dev, ret, NULL,
> > +						ad4052_irq_handler_thresh,
> > +						IRQF_ONESHOT, indio_dev->name,
> > +						indio_dev);
> > +		if (ret)
> > +			return ret;
> > +	} else if (ret == -EPROBE_DEFER) {
> > +		return ret;
> > +	}
> 
> By swapping the order, we can avoid the else. Also, do we really want to
> ignore all other errors? It seems like there would just be ENODEV or ENOENT
> that means the interrupt is not there and we would want to pass on other
> errors.
> 
Ack on the swap order.

If not set on the devicetree, including improper devicetree cases, it
should continue without. If the driver that manages the irq is not
probed, defer probe.

I tested different devicetrees and got:

* any property is missing: -EINVAL
* wrong interrupt-names: -ENODATA
* inconsistent array length between properties: -EOVERFLOW

EPROTO and ENXIO errors are also expected according the method comment,
the latter seems to be when the system doesn't support dts at all? And
EPROTO just another user-set dts issue.
I'm okay with ignoring them silently, or logging if gp0/1 found or not,
but not micromanage every error.

> > +
> >  	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
> >  	if (ret > 0) {
> >  		ret = devm_request_threaded_irq(dev, ret, NULL,
> 
> 
> ...
> 
> > +
> > +static int ad4052_monitor_mode_enable(struct ad4052_state *st)
> > +{
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(&st->spi->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4052_conversion_frequency_set(st, st->events_frequency);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	ret = ad4052_set_operation_mode(st, AD4052_MONITOR_MODE);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	return ret;
> > +out_error:
> > +	pm_runtime_mark_last_busy(&st->spi->dev);
> > +	pm_runtime_put_autosuspend(&st->spi->dev);
> > +	return ret;
> > +}
> > +
> > +static int ad4052_monitor_mode_disable(struct ad4052_state *st)
> > +{
> > +	int ret;
> > +
> > +	pm_runtime_mark_last_busy(&st->spi->dev);
> > +	pm_runtime_put_autosuspend(&st->spi->dev);
> > +
> > +	ret = ad4052_exit_command(st);
> > +	if (ret)
> > +		return ret;
> > +	return regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> > +			    AD4052_REG_DEVICE_STATUS_MAX_FLAG |
> > +			    AD4052_REG_DEVICE_STATUS_MIN_FLAG);
> > +}
> > +
> 
> It seems like we need to make sure monitor mode is disabled when the
> driver is removed. Otherwise we could end up with unbalanced calls to
> the pm_runtime stuff and leave the chip running.
> 
> 
When monitor mode is enabled, pm is already disabled (won't enter low
power). I expect the pm to handle the clean-up properly since devm is
used.
The .remove() I suggest is reg access to:

* Put in configuration mode, if not.
* Put on low power mode, if not.

> > +static int ad4052_read_event_value(struct iio_dev *indio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info, int *val,
> > +				   int *val2)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> > +	}
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		ret = __ad4052_read_event_info_value(st, dir, val);
> > +		break;
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		ret = __ad4052_read_event_info_hysteresis(st, dir, val);
> > +		break;
> 
> These functions don't need __ prefix. There is no name clash.
> 
Ack.

Best regards,
Jorge
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret ? ret : IIO_VAL_INT;
> > +}
> > +

