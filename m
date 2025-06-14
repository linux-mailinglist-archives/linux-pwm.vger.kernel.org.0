Return-Path: <linux-pwm+bounces-6348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C29AD9C17
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C9A189CEBE
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619711E378C;
	Sat, 14 Jun 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4z5xOvm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB978F37;
	Sat, 14 Jun 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749896754; cv=none; b=pWcb8ZCSGWlJhZ6V3jD8LDIDGeQ6zKa/JwE4CFS0rtu4YfbUny+mHUAmY/BGU3hkzr8fCHoG9E8Pm0r/NdLedbR/sxZEa2T6EveK/t2GborN4N67+5Z2pvrdIlETN1woXVSjW/7Z2Ycwuh9vP1YD4qbXZz7MmMLa9qdyCpUqXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749896754; c=relaxed/simple;
	bh=p1ypzCEdSZcEdshLqkRkgA+AcXQZ61zQctwS9jTu9D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDrZV41aUHaBAzvOcJAp0scAocSyor470WQK0SG/omHXV9kmg0SBeoL/rGUCIeyheGEz+QFuk7L/79SVMeHn2zZS1pGofZ1PhEwbZ/5jX+2RdDNeJOQujxZ8Pu5RQAs7rrIafXhpu7zyOWZB7bnho3aoSy/M67QNIYizNUCQemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4z5xOvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B9AC4CEEB;
	Sat, 14 Jun 2025 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749896753;
	bh=p1ypzCEdSZcEdshLqkRkgA+AcXQZ61zQctwS9jTu9D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r4z5xOvm+jqLT3zycFt2CmXGoeHQa6bpdnQunwjWBIfeBw6SrWcnRwNTXi9GG3C2Y
	 rRSm13vocQ13DC4++Z9XZ0I3MYaKPbRpAT/147sE3UYy3javg+kFEokh6q9zYy3OYm
	 a0mPJqeDPlN300RSDtUieivj4+xsL2WN7ywt8Xs/TufUGHDfOBPu7AKUAAhBVfFBAQ
	 CuNJOCTGHMCmPs7IsDFC9i0wzs4fdzGQocNIt+Sq1iTryaYJ3Udxs4KXBneBGkN87v
	 j9qLIUNk1qnOTkPSd7RSweS+04OuJgz8D80CPDSBwxwkcyAtfm1jVysrp7bqY34Mrq
	 krZaMoHGsi2WA==
Date: Sat, 14 Jun 2025 11:25:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <gastmaier@gmail.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Message-ID: <20250614112544.12e6bb30@jic23-huawei>
In-Reply-To: <fa403d19-13c5-4845-9364-58eea1b62e61@baylibre.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
	<afc85a4b-1535-406d-ad14-143049267b98@baylibre.com>
	<gvigk6helnl3yeouy636dgvay7tqux7lnxns3256fivzz4l3er@7ts7fz7vitff>
	<fa403d19-13c5-4845-9364-58eea1b62e61@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 11:03:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/13/25 5:02 AM, Jorge Marques wrote:
> > Hi David,
> > On Thu, Jun 12, 2025 at 02:38:45PM -0500, David Lechner wrote:  
> >> On 6/10/25 2:34 AM, Jorge Marques wrote:  
> >>> The AD4052 family supports autonomous monitoring readings for threshold
> >>> crossings. Add support for catching the GPIO interrupt and expose as an IIO
> >>> event. The device allows to set either, rising and falling directions. Only
> >>> either threshold crossing is implemented.
> >>>
> >>> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> >>> ---  
> >>
> >> ...
> >>  
> >>> +
> >>> +static ssize_t ad4052_events_frequency_store(struct device *dev,
> >>> +					     struct device_attribute *attr,
> >>> +					     const char *buf,
> >>> +					     size_t len)
> >>> +{
> >>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>> +	struct ad4052_state *st = iio_priv(indio_dev);
> >>> +	int ret;
> >>> +
> >>> +	if (!iio_device_claim_direct(indio_dev))
> >>> +		return -EBUSY;
> >>> +	if (st->wait_event) {
> >>> +		ret = -EBUSY;
> >>> +		goto out_release;
> >>> +	}  
> >>
> >> I'm wondering if we should instead have some kind of iio_device_claim_monitor_mode()
> >> so that we don't have to implement this manually everywhere. If monitor mode was
> >> claimed, then iio_device_claim_direct() and iio_device_claim_buffer_mode() would
> >> both return -EBUSY. If buffer mode was claimed, iio_device_claim_monitor_mode()
> >> would fail. If direct mode was claimed, iio_device_claim_monitor_mode() would wait.
> >>  
> > I don't think this would scale with other vendors and devices, it is a  
> 
> Why not? I've seen lots of devices that have some sort of monitor mode
> where they are internally continuously comparing measurements to something
> and only signal an interrupt when some condition is met.

There are lots that support such a monitor, but I think far fewer were direct
accesses don't work at the same time.  The max1363 comes to mind but in that
case it is possible to do both monitor and direct reads it is just that the
data format changes and I think we never bothered implementing the handling
for that combination.

I wouldn't mind such helpers if there are at least a couple of users.

> 
> > limitation of ADI:ADC:SPI requiring to enter configuration mode to read  
> 
> I don't see how it could be a limitiation exclusive to this combination of
> vendor, sensor type and bus type.
> 
> > registers. A deep dive into the other drivers that use IIO Events is
> > needed.  
> >>> +  
> 
> ...
> 
> >>> +
> >>> +static int ad4052_monitor_mode_disable(struct ad4052_state *st)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	pm_runtime_mark_last_busy(&st->spi->dev);
> >>> +	pm_runtime_put_autosuspend(&st->spi->dev);
> >>> +
> >>> +	ret = ad4052_exit_command(st);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +	return regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> >>> +			    AD4052_REG_DEVICE_STATUS_MAX_FLAG |
> >>> +			    AD4052_REG_DEVICE_STATUS_MIN_FLAG);
> >>> +}
> >>> +  
> >>
> >> It seems like we need to make sure monitor mode is disabled when the
> >> driver is removed. Otherwise we could end up with unbalanced calls to
> >> the pm_runtime stuff and leave the chip running.
> >>
> >>  
> > When monitor mode is enabled, pm is already disabled (won't enter low
> > power). I expect the pm to handle the clean-up properly since devm is
> > used.
> > The .remove() I suggest is reg access to:
> > 
> > * Put in configuration mode, if not.
> > * Put on low power mode, if not.
> >   
> I was just thinking something like:
> 
> 	if (st->wait_event)
> 		ad4052_monitor_mode_disable(st);
> 
> Also might need to use devm_add_action_or_reset() instead of .remove
> to get correct ordering.


