Return-Path: <linux-pwm+bounces-1483-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A9854756
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E86D1C274E2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88718E28;
	Wed, 14 Feb 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqpvSUue"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3918635;
	Wed, 14 Feb 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907240; cv=none; b=fF3lG/H8P7CW8lNAKpHW05C8VbTv8uAEE2kw57EmBEo8wDtpfUvdWZjOTC4sCbJ4CNpVqe5Bovr6OGi1aAxpFiX8Sj/9YTDVHbriIrYOJ/+IsrKe9Ds3wwH/rRgxwpgwnXDvC+PT/XYhiIpFRJYFPq9qkqx25WlYdx5mHlyLOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907240; c=relaxed/simple;
	bh=gdpMZjja8skITWzs8w9TDscG6btD+/oplbTXbJ+8UYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/9m8+FwCZIkiSHPpw3+Nwazk8pqaMRtU28mYnLHmg0Q+2Rf9+6p/55GW/3Oh3/Hih9YWTWaxiZ0XTzCviKkH7jc36SpxX4gi+9/deaJ2PG4knRwEbOwvA33RW0+W5CIRxPXQsR1NQop9sqHdztGkKGQ0j9CyKzmfLJfMCLBsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqpvSUue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35077C433A6;
	Wed, 14 Feb 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907240;
	bh=gdpMZjja8skITWzs8w9TDscG6btD+/oplbTXbJ+8UYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqpvSUue55cOFySUYcWX/UfHByLV9ibwIIncLNchgdOSMmXziCoU0oT8JfBn5BiCT
	 HyzWfZkmG3KdyL/mZOWsE7IiCiQlyECP6bhQ0bQbA1zM2HJUMArk8aCfIpN5gAqXLZ
	 Mk5T/czmIqyIPQboOvy6pW7YNKBuPjEhgRs3twT0=
Date: Wed, 14 Feb 2024 11:40:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	linux-pwm@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 155/164] staging: greybus: pwm: Change prototype of
 helpers to prepare further changes
Message-ID: <2024021430-unrushed-explode-5a52@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <ef9b346d5bab508d4ded81cf115bf244938d04f1.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9b346d5bab508d4ded81cf115bf244938d04f1.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:22AM +0100, Uwe Kleine-König wrote:
> This prepares the driver for further changes that will make it harder to
> determine the pwm_chip from a given gb_pwm_chip. To just not have
> to do that, rework gb_pwm_activate_operation(),
> gb_pwm_deactivate_operation(), gb_pwm_config_operation(),
> gb_pwm_set_polarity_operation(), gb_pwm_enable_operation() and
> gb_pwm_disable_operation() to take a pwm_chip. Also use the pwm_chip as
> driver data instead of the gb_pwm_chip.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

