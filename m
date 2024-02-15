Return-Path: <linux-pwm+bounces-1526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6133856309
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF11F246C5
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297412BF15;
	Thu, 15 Feb 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AkIrjtZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2H1WnTaa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AkIrjtZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2H1WnTaa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631B12BF0A;
	Thu, 15 Feb 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999831; cv=none; b=uEujIiakA59Sah93yQGlA343FVHbqkXNIaBjk9QCIID4gZEI5Qzfp6OikCcxsJU+lhKbWz48osalb5IujD3TB73u5g8UgNRWQCQu3Ylt2OmdsKnJPDKS9BzpVSgQIS96V42e5QrSrScf3cS9FMr943zlvZWRgSaCeiGaV/L3vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999831; c=relaxed/simple;
	bh=ryXmnrVKdJ1IArgbO2BYploNe2lnXcSAchTy7PIdIS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkBM8dXbSuEz12NYFenmjC8Gk2bAYlRRwS3b5MssaQR00L7FHsdbl29+fje+wJO72c6uOCzRPBBmghlpz71oB/fFj/8z2Cb1xP41j/307uSFgkFxtD4Fexkv++qlf0QJBa6Rxrs0O+4urr1DKCv88UwI6Kt98cwo6I8niFJqDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AkIrjtZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2H1WnTaa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AkIrjtZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2H1WnTaa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE70022031;
	Thu, 15 Feb 2024 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707999821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/U6IOQnQ9ULxqaNESpPiiOjak9SURfZzGnFmX/IjxEY=;
	b=AkIrjtZZEVtDAFn9jXGZtbagNGWHuxq3IJPaA9xl0/PtGsnmw6NcLPCgPQ93zVgkHmQNGm
	uK9HNkgdugSlWX/rpuHg6qBVpOB3nn+aUatljjablitZxY/SHYJmKaAJQdEsjdhUIHG6nj
	R7/eUTdt3b2q8eItziNDW9PC0R6Ky/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707999821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/U6IOQnQ9ULxqaNESpPiiOjak9SURfZzGnFmX/IjxEY=;
	b=2H1WnTaaHm9T8o62IZKF/gnL7LWzFfrG6KKWSjrfBCKS2ZbazyuWgKpnzqlUSGJQ2yQa5O
	poKcn9yFTOqetKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707999821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/U6IOQnQ9ULxqaNESpPiiOjak9SURfZzGnFmX/IjxEY=;
	b=AkIrjtZZEVtDAFn9jXGZtbagNGWHuxq3IJPaA9xl0/PtGsnmw6NcLPCgPQ93zVgkHmQNGm
	uK9HNkgdugSlWX/rpuHg6qBVpOB3nn+aUatljjablitZxY/SHYJmKaAJQdEsjdhUIHG6nj
	R7/eUTdt3b2q8eItziNDW9PC0R6Ky/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707999821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/U6IOQnQ9ULxqaNESpPiiOjak9SURfZzGnFmX/IjxEY=;
	b=2H1WnTaaHm9T8o62IZKF/gnL7LWzFfrG6KKWSjrfBCKS2ZbazyuWgKpnzqlUSGJQ2yQa5O
	poKcn9yFTOqetKDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A0D11346A;
	Thu, 15 Feb 2024 12:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2CNtGE0CzmXADAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 15 Feb 2024 12:23:41 +0000
Message-ID: <288a480c-74e9-49dd-a58d-294792771ea6@suse.de>
Date: Thu, 15 Feb 2024 13:23:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] backlight: Replace struct fb_info in interfaces
Content-Language: en-US
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240215121326.GL9758@aspen.lan>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240215121326.GL9758@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AkIrjtZZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2H1WnTaa
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,gmx.de,redhat.com,lists.freedesktop.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE70022031
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi

Am 15.02.24 um 13:13 schrieb Daniel Thompson:
> On Mon, Feb 12, 2024 at 05:16:33PM +0100, Thomas Zimmermann wrote:
>> Backlight drivers implement struct backlight_ops.check_fb, which
>> uses struct fb_info in its interface. Replace the callback with one
>> the does not use fb_info.
>>
>> In DRM, we have several drivers that implement backlight support. By
>> including <linux/backlight.h> these drivers depend on <linux/fb.h>.
>> At the same time, fbdev is deprecated for new drivers and likely to
>> be replaced on many systems.
>>
>> This patchset is part of a larger effort to implement the backlight
>> code without depending on fbdev.
>>
>> Patch 1 makes the backlight core match backlight and framebuffer
>> devices via struct fb_info.bl_dev. Patches 2 to 9 then go through
>> drivers and remove unnecessary implementations of check_fb. Finally,
>> patch 10 replaces the check_fb hook with controls_device, which
>> uses the framebuffer's Linux device instead of the framebuffer.
> I won't reply individually but I also took a look at the patches for
> the combo devices and it all looked good to me from a backlight
> point of view.
>
> However I don't want to drop Reviewed-by: on them since it risks those
> bit being mistaken for an ack and merged ahead of the patch 1...

Thanks for reviewing. Unless someone objects, my intention is to merge 
everything via the drm-misc, so all patches should go in at once. I do 
have a lot more patches that untangle backlight and fbdev almost 
completely, but most of these changes are in the actual graphics drivers 
rather than the backlight core code. So hopefully everything can go 
through the DRM tree; or maybe the fbdev tree.

Best regards
Thomas

>
>
> Daniel.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


