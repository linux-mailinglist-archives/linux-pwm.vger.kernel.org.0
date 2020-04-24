Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0804E1B81EE
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2020 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgDXWSH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Apr 2020 18:18:07 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34019 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgDXWSH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Apr 2020 18:18:07 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Apr 2020 15:17:57 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 24 Apr 2020 15:17:56 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id D1A8C4C90; Fri, 24 Apr 2020 15:17:56 -0700 (PDT)
Date:   Fri, 24 Apr 2020 15:17:56 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v13 01/11] drm/i915: Use 64-bit division macro
Message-ID: <20200424221756.GB31118@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <4a3acf8673c08308848fb7ae73d992b6feb758d3.1587523702.git.gurus@codeaurora.org>
 <87ftctbe5l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftctbe5l.fsf@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 24, 2020 at 09:17:58AM +0300, Jani Nikula wrote:
> On Tue, 21 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > Since the PWM framework is switching struct pwm_state.duty_cycle's
> > datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
> > to handle a 64-bit dividend.
> >
> > To: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> >
> 
> Superfluous blank line.

Will remove.

> 
> Anyway, please preserve the existing acks and reviews [1] so people
> don't have to do it again.
> 
> BR,
> Jani.
> 
> [1] http://lore.kernel.org/r/87h7yleb0i.fsf@intel.com

I dropped your Acked-by as the patch had to changed to resolve a merge
conflict when I rebased to tip. Could you please re-review this patch?

Thank you.

Guru Das.
