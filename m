Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5198D410606
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Sep 2021 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhIRLT4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Sep 2021 07:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhIRLT4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 18 Sep 2021 07:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BD4B6103B;
        Sat, 18 Sep 2021 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631963913;
        bh=VAWiAZOGoe7mLIkbnTlowYsP6nJuWlmaRXx0+BU2gko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTw/3H6bIVkwgCwVndNvUJ2N6GSB+GzYT5Nqv+aBgJNlU2YLtSwO3o1+98WGizGXM
         hxmfRomuLMPIAtglkoXZ20JpzjFGL+B1OYb8SequBD76vIwKiXmmRddeCmPsDDmgA1
         5GCbhxxQcvoK3YXlB7uT0zOVfwww3EOMA9ngGGZE=
Date:   Sat, 18 Sep 2021 13:18:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Message-ID: <YUXK/4/1uYBjJt7S@kroah.com>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> From: Fenglin Wu <fenglinw@codeaurora.org>
> 
> Normally, PWM channel has fixed output until software request to change
> its settings. There are some PWM devices which their outputs could be
> changed autonomously according to a predefined pattern programmed in
> hardware. Add pwm_output_type enum type to identify these two different
> PWM types and add relevant helper functions to set and get PWM output
> types and pattern.
> 
> Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e

This is not needed an a upstream patch, checkpatch should have told you
:(

> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  | 26 ++++++++++++++++++++
>  drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++

You forgot a Documentation/ABI/ update for your new sysfs file :(

thanks,

greg k-h
