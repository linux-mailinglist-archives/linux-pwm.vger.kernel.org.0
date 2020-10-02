Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466C6281306
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgJBMoL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 08:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMoL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 08:44:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1803920672;
        Fri,  2 Oct 2020 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601642649;
        bh=c+DRCXODZXiAWU+WmseGXdjZpDoVuIsImezop5VomhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd9faxk4NO38dpz/1ZxWf8sYt68XNWhNZ5PeDY7RBVfWLoOY4iNGwjHanbjpsCuV4
         FoTh+UHRbHk/6W8Ky1SBbQAFvr/Dfpu+MGR2n3gk7GsfRZylqSmdgmAj7Kj7z9mgRD
         wPV+V7C4ys+fPMCXWdtoGyj8E/bb4gREv/2KQO9I=
Date:   Fri, 2 Oct 2020 14:44:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     poeschel@lemonage.de
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pwm: sysfs: Set class on pwm devices
Message-ID: <20201002124407.GA3348424@kroah.com>
References: <20201002123048.3073128-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002123048.3073128-1-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 02, 2020 at 02:30:47PM +0200, poeschel@lemonage.de wrote:
> +	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=%s",
> +			export->child.kobj.name);

Nit, you should use dev_name() here instead of trying to get the raw
kobject name.


thanks,

greg k-h
