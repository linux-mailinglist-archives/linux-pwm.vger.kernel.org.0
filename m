Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041FC13D14A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jan 2020 01:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgAPAzF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 19:55:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55969 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgAPAzF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jan 2020 19:55:05 -0500
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jan 2020 16:55:04 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 15 Jan 2020 16:55:04 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id E2573499B; Wed, 15 Jan 2020 16:55:03 -0800 (PST)
Date:   Wed, 15 Jan 2020 16:55:03 -0800
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20200116005503.GA8559@codeaurora.org>
References: <cover.1578959442.git.gurus@codeaurora.org>
 <21a1431edfa86e061528b80021351c25c76976a9.1578959442.git.gurus@codeaurora.org>
 <20200114074710.kxkz4664oap3r752@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114074710.kxkz4664oap3r752@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jan 14, 2020 at 08:47:10AM +0100, Uwe Kleine-König wrote:
> I didn't thought about that much, but it would be great if we could
> prepare the affected drivers to work with both, int and u64 and switch
> in a separate commit. Reverting would then become cheaper.
> The conversion to 64-bit division macros could be done even without
> actually converting period and duty cycle, couldn't it?

I do agree that with such a two-step process the reverting (should the
need arise) would be much cheaper. I tried out your suggestion and saw
that this is not possible as the patch stands currently due to
compilation warning and errors that arise for various architectures:

warning: comparison of distinct pointer types lacks a cast
warning: right shift count >= width of type [-Wshift-count-overflow]
error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'unsigned int *'
warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]

Could you please indicate how we should proceed further?

> This Reported-by: looks wrong. It gave some hints about what had to be
> improved in an earlier revision of this patch, but usually this means
> that the patch is a fix for an earlier commit. So I would put this in
> the text, something like:
> 
> 	The kbuild test robot helped to improve this patch series to
> 	(hopefully) catch all code sites having to be adapted.

Noted, will make this change.

> In ir-rx51.c you used DIV_ROUND_CLOSEST_ULL to replace
> DIV_ROUND_CLOSEST, here it is DIV64_U64_ROUND_CLOSEST. Maybe it is worth
> to describe the relevant difference shortly in the commit log.

Sure, will make a note of this in the commit log. In short, one is used
when only the numerator is 64-bit while the other is meant for the case
when both numerator and denominator are 64-bit.

Thank you.

Guru Das.
