Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234961BA55B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgD0Nsr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 27 Apr 2020 09:48:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:53448 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgD0Nsr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Apr 2020 09:48:47 -0400
IronPort-SDR: gFAqEpeI9ldKMeOMw1fFq+dZMxQKabre4yURlir7iAGiEsvalw7Q7Cd6lzTHoKGMlYZsKG4sup
 7zvrceLm/HKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 06:48:47 -0700
IronPort-SDR: s4oIVuVu3USfWnW80U/6zKOUmltoh8xzO52WmN/+qPMXyWhsz+Of1qcrWEQBhYSq2o6YbT/La6
 mPxnhwx3hxBg==
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="431781142"
Received: from mbrowarx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.47.15])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 06:48:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
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
In-Reply-To: <20200424221756.GB31118@codeaurora.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1587523702.git.gurus@codeaurora.org> <4a3acf8673c08308848fb7ae73d992b6feb758d3.1587523702.git.gurus@codeaurora.org> <87ftctbe5l.fsf@intel.com> <20200424221756.GB31118@codeaurora.org>
Date:   Mon, 27 Apr 2020 16:48:39 +0300
Message-ID: <87y2qh9gzs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 24 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> On Fri, Apr 24, 2020 at 09:17:58AM +0300, Jani Nikula wrote:
>> On Tue, 21 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>> > Since the PWM framework is switching struct pwm_state.duty_cycle's
>> > datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
>> > to handle a 64-bit dividend.
>> >
>> > To: Jani Nikula <jani.nikula@linux.intel.com>
>> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> > Cc: David Airlie <airlied@linux.ie>
>> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> > Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
>> > Cc: intel-gfx@lists.freedesktop.org
>> > Cc: dri-devel@lists.freedesktop.org
>> >
>> 
>> Superfluous blank line.
>
> Will remove.
>
>> 
>> Anyway, please preserve the existing acks and reviews [1] so people
>> don't have to do it again.
>> 
>> BR,
>> Jani.
>> 
>> [1] http://lore.kernel.org/r/87h7yleb0i.fsf@intel.com
>
> I dropped your Acked-by as the patch had to changed to resolve a merge
> conflict when I rebased to tip. Could you please re-review this patch?

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel Open Source Graphics Center
