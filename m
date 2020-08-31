Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4787A257FFC
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaR5l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 13:57:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgHaR5k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 13:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598896657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fta6S09NuQr3NtP1v0gU8NpMcMvdjL+BAFEBhoAl3nw=;
        b=KkaMt8VQglzDw2D0h3O0OQLw2zFWUs0VOnxfFgwLet+gOmwj5/NSJXV0XXYMMT4gdhdZuz
        UV7+viKYoxhm/SO5VZuaT4jJlDYVey/OS2g5S5NFxRv3xfcFXhnQIGUPirtIEFMrRsEXB1
        C0TrOCHgLEN64h9w0GfjeDJuYUJR9eM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-iYR1ew_9O2eyavW7NGkmQw-1; Mon, 31 Aug 2020 13:57:33 -0400
X-MC-Unique: iYR1ew_9O2eyavW7NGkmQw-1
Received: by mail-ed1-f69.google.com with SMTP id c25so775163edx.11
        for <linux-pwm@vger.kernel.org>; Mon, 31 Aug 2020 10:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fta6S09NuQr3NtP1v0gU8NpMcMvdjL+BAFEBhoAl3nw=;
        b=GdcCe/7Z7VL6ndRp+CGuwvHhuj/ZOLWRlzsqY7bB7OrF2RScC9ejsWQOsAeo+K7RgP
         2KLvxrhau2W0Sf0GDTTIKuVlWKC/XEcFmfCEIVeKMOWn8mPZYjrPgGjm9cEmaGNf2rp4
         zZWiLwSbryvo5QoBTDUeoulp5dYrc74kt1maD+VKzBzZvvyu6xJQMBupzyT4tFqmRj6J
         ofb5Jx+lwPnpXL5IrOFlaXY/NHT8NyPT8OKno9D7s/BVxyPOKXDlc98LjOF10OAC5kUc
         34CBeY3a3iaQ/BsRDu4c5UkQbmeH0DzJbpIrvpxTVt3vfOjbKBlBMlJ8XtzKWeYUCHTE
         /JJQ==
X-Gm-Message-State: AOAM533tiewvqzHl1c4rJ/hvY6ChZFzpeOb5gRqYgmeGb/vBQl06d9Ol
        oaVB6xjHa0jGLYzWkHNSdlxfeFBgpHDXn8xulvzfaFTtk2sk48lGuj6hF39yoYUlkKrguY78+u6
        kcWtI9MoKGD8oMcwNrYZR
X-Received: by 2002:a05:6402:1710:: with SMTP id y16mr2304635edu.197.1598896652401;
        Mon, 31 Aug 2020 10:57:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTNia0aR3ARSWP7er9341p7NKAJ9h4bBKpm7KmLb2FIjWe4rKAGXCJJRlp89QldRBCgqjSUw==
X-Received: by 2002:a05:6402:1710:: with SMTP id y16mr2304604edu.197.1598896651988;
        Mon, 31 Aug 2020 10:57:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l23sm8703136eje.46.2020.08.31.10.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:57:31 -0700 (PDT)
Subject: Re: [PATCH v8 06/17] pwm: lpss: Use pwm_lpss_restore() when restoring
 state on resume
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-7-hdegoede@redhat.com> <20200831111006.GD1688464@ulmo>
 <d63a89d2-84e5-ca05-aa96-a06291503c5f@redhat.com>
 <20200831131533.GI1689119@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <84887293-11b3-82c9-1e62-bac39861e39e@redhat.com>
Date:   Mon, 31 Aug 2020 19:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831131533.GI1689119@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 8/31/20 3:15 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 01:46:28PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 8/31/20 1:10 PM, Thierry Reding wrote:
>>> On Sun, Aug 30, 2020 at 02:57:42PM +0200, Hans de Goede wrote:
>>>> Before this commit a suspend + resume of the LPSS PWM controller
>>>> would result in the controller being reset to its defaults of
>>>> output-freq = clock/256, duty-cycle=100%, until someone changes
>>>> to the output-freq and/or duty-cycle are made.
>>>>
>>>> This problem has been masked so far because the main consumer
>>>> (the i915 driver) was always making duty-cycle changes on resume.
>>>> With the conversion of the i915 driver to the atomic PWM API the
>>>> driver now only disables/enables the PWM on suspend/resume leaving
>>>> the output-freq and duty as is, triggering this problem.
>>>
>>> Doesn't this imply that there's another bug at play here? At the PWM API
>>> level you're applying a state and it's up to the driver to ensure that
>>> the hardware state after ->apply() is what the software has requested.
>>>
>>> If you only switch the enable state and that doesn't cause period and
>>> duty cycle to be updated it means that your driver isn't writing those
>>> registers when it should be.
>>
>> Right, the driver was not committing those as it should *on resume*,
>> that and it skips setting the update bit on the subsequent enable,
>> which is an optimization which gets removed in 7/17.
>>
>> Before switching the i915 driver over to atomic, when the LPSS-PWM
>> was used for the backlight we got the following order on suspend/resume
>>
>> 1. Set duty-cycle to 0%
>> 2. Set enabled to 0
>> 3. Save ctrl reg
>> 4. Power-off PWM controller, it now looses all its state
>> 5. Power-on PWM ctrl
>> 6. Restore ctrl reg (as a single reg write)
>> 7. Set enabled to 1, at this point one would expect the
>> duty/freq from the restored ctrl-reg to apply, but:
>> a) The resume code never sets the update bit (which this commit fixes); and
>> b) On applying the pwm_state with enabled=1 the code applying the
>> state does this (before setting the enabled bit in the ctrl reg):
>>
>> 	if (orig_ctrl != ctrl) {
>> 		pwm_lpss_write(pwm, ctrl);
>> 		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
>> 	}
>> and since the restore of the ctrl reg set the old duty/freq the
>> writes are skipped, so the update bit never gets set.
>>
>> 8. Set duty-cycle to the pre-suspend value (which is not 0)
>> this does cause a change in the ctrl-reg, so now the update flag
>> does get set.
>>
>> Note that 1-2 and 7-8 are both done by the non atomic i915 code,
>> when moving the i915 code to atomic I decided that having these
>> 2 separate steps here is non-sense, so the new i915 code just
>> toggles the enable bit. So in essence the new atomic PWM
>> i915 code drops step 1 and 8.
>>
>> Dropping steps 8 means that the update bit never gets set and we
>> end up with the PWM running at its power-on-reset duty cycle.
>>
>> You are correct in your remark to patch 7/17 that since that removes
>> the if (orig_ctrl != ctrl) for the writes that now step 7 will be
>> sufficient to get the PWM to work again. But that only takes the i915
>> usage into account.
>>
>> What if the PWM is used through the sysfs userspace API?
>> Then only steps 3-6 will happen on suspend-resume and without
>> fixing step 6 to properly restore the PWM controller in its
>> pre-resume state (this patch) it will once again be running at
>> its power-on-reset defaults instead of the values from the
>> restored control register.
> 
> Actually PWM's sysfs code has suspend/resume callbacks that basically
> make sysfs just a regular consumer of PWMs. So they do end up doing a
> pwm_apply_state() on the PWM as well on suspend and restore the state
> from before suspend on resume.
> 
> This was done very specifically because the suspend/resume order can be
> unexpected under some circumstances, so for PWM we really want for the
> consumer to always have ultimate control over when precisely the PWM is
> restored on resume.
>
> The reason why we did this was because people observed weird glitches on
> suspend/resume with different severity. In some cases a backlight would
> be resumed before the display controller had had a chance to start
> sending frames, causing on-screen corruption in some cases (such as
> smart displays) and in other cases a PWM-controller regulator would be
> resumed too late or too early, which I think was causing some issue with
> the CPUs not working properly on resume.
> 
> So I'd prefer not to have any PWM driver save and restore its own
> context on suspend/resume, because that's inevitably going to cause
> unexpected behaviour at some point. If it's absolutely necessary we can
> of course still do that, but I think in that case we need to at least
> add a comment in the code about why context save/restore is needed in
> this particular case and make it clear that this is not something that
> other drivers should copy because they most likely won't be needing it.
> 
> Given the above it also doesn't sound to me like there's a real problem,
> or at least that the bug is somewhere else. A consumer should always be
> responsible for applying the pre-suspend state upon resume and it sounds
> like that would be true after patch 7. Since sysfs is just a regular
> consumer, the same should apply for sysfs-controlled PWMs as well.

Ok, I was not aware that for PWM the consumer is supposed to always
be the one to restore the state. If that is the rule then we should probably
just drop the save/restore suspend/resume code from pwm-lpss.

It seems that I'm actually responsible for adding that suspend/resume
code in the first place, see commit 1d375b58c12f ("pwm: lpss: platform:
Save/restore the ctrl register over a suspend/resume") although the
ctrl-register was already being saved/restored before that commit
but then by the acpi/acpi_lpss.c code.

One worry after dropping the suspend/resume save/restore code is what
happens if the controller was enabled at the moment the system suspends
and the consumers first post resume apply() call has pwm_state.enabled
set too.

Currently pwm_lpss_apply() looks like this:

         if (state->enabled) {
                 if (!pwm_is_enabled(pwm)) {
                         pm_runtime_get_sync(chip->dev);
                         ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
                         if (ret)
                                 pm_runtime_put(chip->dev);
                 } else {
                         ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
                 }
         } else if (pwm_is_enabled(pwm)) {

Where the true / false parameter to pwm_lpss_prepare_enable()
decides if pwm_lpss_prepare_enable() sets the enable bit in the controllers
ctrl register, or if it skips that.

If we then come from a full system suspend (controller loses state,
comes up with enable bit cleared) we will still enter the:

                         ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);

Path since the !pwm_is_enabled(pwm) check checks the pwm_state struct,
not the actual hw-enabled bit and then we do not (re)set the enabled after
resume as we should when apply() is called with pwm_state.enabled set.

Fixing this is easy though, we still need to check for the disabled ->
enabled transition for runtime pm refcounting, but we can also tell
pwm_lpss_prepare_enable() to set the enable bit in the other path, this
will be a no-op in case it is already set.

So then the new apply() code would become:

         if (state->enabled) {
                 if (!pwm_is_enabled(pwm)) {
                         pm_runtime_get_sync(chip->dev);
                         ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
                         if (ret)
                                 pm_runtime_put(chip->dev);
                 } else {
                         ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
                 }
         } else if (pwm_is_enabled(pwm)) {

(and we can even optimize out the enable parameter to pwm_lpss_prepare_enable
then and always make it set the enable bit).

Together with patch 07/16 will make apply() always work independent of
the state the controller was in before it got called. Which in light of
all the subtle issues we have seen surrounding this is likely a good thing.

And with the fix to make apply() fully independent of the previous state
of the controller, I'm all for dropping the suspend/resume state
save/restore code.  Doing that makes things more KISS so I like it :)

>> So at step 6, if the PWM was enabled before, we must set the update
>> bit, and then wait for it to clear again so the controller is
>> ready for subsequent updates. The waiting for it to clear again
>> needs to happen before or after setting the enable bit depending
>> on the hw generation, which leads to this patch.
> 
> But all of that should be happening as part of the call to
> pwm_apply_state(), right? That path should be taken for all consumers on
> resume, including sysfs.

Ack.

<snip>

>> See above, apply() was trying to be smart but the restore of ctrl
>> on resume without setting the update bit was tricking it. That
>> being too smart for its own good is removed in 7/16 as you
>> rightfully point out. But this patch is still necessary for the
>> PWM controller to be in the expected state between resume and the
>> first apply() after resume (which may be quite a long time in
>> the future when using e.g. the sysfs API).
> 
> Like I said, the sysfs code should be resuming any exported PWMs on
> resume just like any other consumer.
> 
> Obviously it's always up to the consumer to call pwm_apply_state() at
> the right time. If that's "too late" for some reason, then that's a bug
> in the consumer driver. But as I explained above there are a number of
> cases where restoring context in the PWM driver itself doesn't work
> because it can cause sequencing issues.

Ack, I was not aware that PWM consumers are responsible for restoring
their own state on resume. If that is the case then:

TL;DR:

1. We (I) should make apply() work independent of the current
hardware state, instead of having it make various assumptions
about that state as it now does.

2. We (I) should drop the suspend/resume save/restore state
handlers from pwm-lpss completely.

So I believe that I should prepare yet another version of this
patch-set replacing 06/17 and 07/17 with 2 patches doing these
2 things.

Thierry, Andy, does that sound good to you ?

Regards,

Hans

