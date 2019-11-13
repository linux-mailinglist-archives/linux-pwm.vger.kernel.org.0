Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92F9FB909
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Nov 2019 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMTnM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 13 Nov 2019 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMTnM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 13 Nov 2019 14:43:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076B9206E1;
        Wed, 13 Nov 2019 19:43:11 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:43:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: implement tracing for .get_state() and
 .apply_state()
Message-ID: <20191113144309.54b19011@gandalf.local.home>
In-Reply-To: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
References: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 24 Oct 2019 10:08:29 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> This allows to log all calls to the driver's lowlevel functions which
> simplifies debugging in some cases.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I didn't add a trace call to .get_state added in 
> 01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented state")
> in the expectation that this will be reverted very soon anyhow and
> addint it there would only complicate reverting (or applying this
> patch).
> 
> Best regards
> Uwe
> 
>  drivers/pwm/core.c         |  9 +++++-
>  include/trace/events/pwm.h | 58 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/pwm.h
> 
>

From the tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
